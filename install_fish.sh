# fish shell安装
brew cask install fish

# 将fish添加到mac shell列表中
sudo bash -c "echo '/usr/local/bin/fish' >> /etc/shells"

# fish 配置
ln -sfv $BASE/.config/fish/aliases.fish ~/.config/fish/aliases.fish
ln -sfv $BASE/.config/fish/config.fish ~/.config/fish/config.fish
ln -sfv $BASE/.config/fish/env.fish ~/.config/fish/env.fish

# fish 函数
mv ~/.config/fish/functions ~/.config/fish/functions_bck
ln -sfv $BASE/.config/fish/functions ~/.config/fish/functions
mv -r ~/.config/fish/functions_bck/* ~/.config/fish/functions/
rm -rf ~/.config/fish/functions_bck

# 安装fish的包管理工具
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# fisher的插件需要自己执行添加
fisher add jethrokuan/z
fisher add rafaelrinaldi/pure
