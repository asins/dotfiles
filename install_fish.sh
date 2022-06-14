# fish shell安装
brew install fish

# 将fish添加到mac shell列表中
sudo bash -c "echo '/usr/local/bin/fish' >> /etc/shells"

#RC files
cd $(dirname $BASH_SOURCE)
BASE_PATH=$(pwd)

# fish 配置
ln -sfv $BASE_PATH/.config/fish/aliases.fish ~/.config/fish/aliases.fish
ln -sfv $BASE_PATH/.config/fish/config.fish ~/.config/fish/config.fish
ln -sfv $BASE_PATH/.config/fish/env.fish ~/.config/fish/env.fish

# fish 函数
mv ~/.config/fish/functions ~/.config/fish/functions_bck
ln -sfv $BASE_PATH/.config/fish/functions ~/.config/fish/functions
mv ~/.config/fish/functions_bck/* ~/.config/fish/functions/
rm -rf ~/.config/fish/functions_bck

# 安装fish的包管理工具
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher


# fisher的插件需要自己执行添加
fisher install jethrokuan/z
fisher install IlanCosman/tide@v5
