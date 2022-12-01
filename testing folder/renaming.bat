@echo off
rem start at the top of the tree to visit and loop though each directory
for /r %%a in (.) do (
  rem enter the directory
  pushd %%a
  echo In directory:
  cd
  rem leave the directory
  popd
  )
timeout /t 10