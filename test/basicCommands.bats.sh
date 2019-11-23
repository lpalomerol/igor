#!/usr/bin/env bats

@test "basic.Display version (short)" {
  VERSION=$(igor -v | sed 's/version.*/version/')
  echo $VERSION
  [ "$VERSION" == "Igor version" ]
}

@test "basic.Display version (long)" {
  VERSION=$(igor --version | sed 's/version.*/version/')
  echo $VERSION
  [ "$VERSION" == "Igor version" ]
}

@test "basic.Display help (short)" {
  VERSION=$(igor -h | head -1)
  echo $VERSION
  [ "$VERSION" == "igor [-h] -- Igor suite, help tool to manage R-bash projects" ]
}


@test "basic.Display help (long)" {
  VERSION=$(igor --help | head -1)
  echo $VERSION
  [ "$VERSION" == "igor [-h] -- Igor suite, help tool to manage R-bash projects" ]
}
