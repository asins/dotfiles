# brew update command

function bubu --description '更新brew及所有已安装软件'
    brew update
    brew outdated

    brew upgrade
    brew cleanup

    # brew cu -acy --cleanup # 不强制安装latest的软件
    brew cu -facy
end
