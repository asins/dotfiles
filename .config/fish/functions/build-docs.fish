function build-docs -d '文档构建机手动生成文档'
  # ./data/task_list/0395TM7MY1GH9PFD3028GRUDQ/json_to_html

  # ======= 以下为方法定义 =======

  # 确定构建语言
  function getBuildLang --no-scope-shadowing
    if test -e ../git_source/package.json
      echo 'ts'
    else if test -e ../git_source/build.gradle
      echo 'java'
    else if test -e ../git_source/ACGGamePaasSDK.podspec
      echo 'oc'
    else
      echo '未识别的语言'
    end
  end

  # 删除构建临时内容
  function cleanBuildDirs --no-scope-shadowing
    cd $curr

    rm -rf ./data
    rm -rf ./docs
    rm -rf ../git_source/build_docs
  end

  # 进入源码目录，更新数据源
  function updateGitSource --no-scope-shadowing
    cd $curr
    cd ../git_source

    git reset --hard HEAD
    git pull --rebase

    cd $curr
  end

  # 在源码目录中构建出Json格式的文档
  function buildJsonDocOnGitSource --no-scope-shadowing
    cd $curr
    cd ../git_source

    if [ $lang = 'oc' ]
      doxygen ./Script/Doxyfile
      mkdir -p ./build_docs/json
      ~/.bin/doxybook2 --input ./build_docs/xml --output ./build_docs/json --json
      cp -rf ./build_docs ../json_to_html/data
      cp -rf ./docs ../json_to_html/docs
    else if [ $lang = 'java' ]
      doxygen ./Doxyfile
      mkdir -p ./build_docs/json
      ~/.bin/doxybook2 --input ./build_docs/xml --output ./build_docs/json --json
      cp -rf ./build_docs ../json_to_html/data
      cp -rf ./docs ../json_to_html/docs
    else if [ $lang = 'ts' ]
      npm run doc
      mkdir -p ../json_to_html/data/json
      cp -rf ./build_docs/output.json ../json_to_html/data/json/output.json
      cp -rf ./docs ../json_to_html/docs
    else
      echo "[Error]未识别出待构建的语言，无法继续构建"
    end

    cd $curr
  end

  # 在源码目录中构建出Json格式的文档
  function buildHtmlDoc --no-scope-shadowing
    cd $curr

    npm run $lang
    npm run build
  end

  # 开始执行创建的步骤
  function run_steps --no-scope-shadowing
    set_color brgreen; echo \n\n"指定执行步骤: $step_name"; set_color normal

    if string match -q "1" $step_name
      set_color red; echo \n"[执行] 1:cleanBuildDirs 删除构建临时内容"; set_color normal

      cleanBuildDirs
    end

    if string match -q "2" $step_name
      set_color red; echo \n"[执行] 2:updateGitSource 删除构建临时内容"; set_color normal

      updateGitSource
    end

    if string match -q "3" $step_name
      set_color red; echo \n"[执行] 3:updateGitSource 进入源码目录，生成新的数据源"; set_color normal

      buildJsonDocOnGitSource
    end

    if string match -q "4" $step_name
      set_color red; echo \n"[执行] 4:buildHtmlDoc 在源码目录中构建出Json格式的文档"; set_color normal

      buildHtmlDoc
    end
  end

  # 获取源码仓库分支信息
  function getSourceBranchInfo --no-scope-shadowing
    cd $curr
    cd ../git_source

    echo (git branch 2>/dev/null | grep \* | sed 's/* //')

    cd $curr
  end

  # 获取Docusaurus.config.js中baseUrl信息
  function getDocusaurusBaseUrl
    cat "./docusaurus.config.js" | grep "baseUrl: '\(.*\)'" | awk -F \' '{ print $2 }'
  end


  # ======= 以下开始执行脚本 =======
  set -f curr (pwd)
  set -f baseUrl (getDocusaurusBaseUrl)

  if not string match -q -e "/json_to_html" $curr
    echo "[Error]未在文档构建机任务的json_to_html目录中，无法执行脚本！"
    return
  end

  set -f lang (getBuildLang)
  set -f git_cb (getSourceBranchInfo)
  set_color brgreen
  echo "执行目录: $curr"
  echo "生成的语言: $lang, 源码分支: $git_cb"
  set_color normal

  # 入参定义
  set -f step_name
  getopts $argv | while read -l key value
    switch $key
      case h help
        echo "文档构建机手动生成文档"
        echo "Usage: build-docs [OPTIONS]"\n
        echo "Options:"
        echo "  -h/--help       打印帮助信息并退出"
        echo "  -s/--step=1,2,3,4 执行的步骤列表（逗号分隔）"
        return
      # case _
      case s step
        set step_name $step_name (string split ',' $value)
    end
  end

  if not test -n "$step_name"
    set step_name $step_name (string split ',' '1,2,3,4')
  end

  # return

  run_steps

  set_color brgreen;
  echo \n"构建完成: 语言: $lang, 源码分支: $git_cb"
  echo "文档Url: $BUILD_DOC_WEB_DOMAIN/$baseUrl";
  set_color normal
end

