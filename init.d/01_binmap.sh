for tool in "$CDAPROD_HOME/tools/"*/; do
  TOOLNAME=$(basename "$tool")
  TARGET="$CDAPROD_HOME/bin/$TOOLNAME"
  LINK="/usr/local/cdaprod/bin/$TOOLNAME"
  
  if [ -L "$LINK" ] || [ ! -e "$LINK" ]; then
    ln -sf "$TARGET" "$LINK"
  else
    echo "[!] Skipping $TOOLNAME -- file already exists at $LINK and is not a symlink."
  fi
done