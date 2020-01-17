function inGit() {
  if [ -d .git ]; then
      echo .git;
  else
      git rev-parse --git-dir 2> /dev/null;
  fi;  
}
