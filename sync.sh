cp -r ~/.tmux.conf ~/.config/helix ~/.config/alacritty ./
git add .
git commit -m "synced $(date)"
git push -u origin main


