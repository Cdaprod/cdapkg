if ! grep -q "share/man" ~/.bashrc; then
  echo 'export MANPATH="$CDAPROD_HOME/share/man:$MANPATH"' >> ~/.bashrc
fi