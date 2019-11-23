#!/usr/bin/env bats
load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'


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
  OUT=$(igor --help | head -1)
  echo $OUT
  [ "$OUT" == "igor [-h] -- Igor suite, help tool to manage R-bash projects" ]
}


@test "basic.Display help: Display can be created" {
  run igor -h

  assert_output --partial client: Creates a client
  assert_output --partial project: Creates a project
  assert_output --partial rmd: Creates a Rmd file

}
