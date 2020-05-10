open() {
   dot system open "$@"
}

pbcopy() {
   dot system clip copy
}

pbpaste() {
   dot system clip paste
}

echos() {
   limit="${1:-22}"
   for i in {1..$limit}
      do
         echo "--------------------------------------------------------------------------------"
      done
}