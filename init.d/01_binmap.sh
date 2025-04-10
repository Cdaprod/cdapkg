for tool in "$CDAPROD_HOME/tools/"*/; do
  TOOLNAME=$(basename "$tool")
  ln -sf "$tool/$TOOLNAME" "/usr/local/cdaprod/bin/$TOOLNAME"
done