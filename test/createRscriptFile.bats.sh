#!/usr/bin/env bats
load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'


setup() {


  TEST_PROJECT="./tmp/test_client/test_project"
  mkdir -p $TEST_PROJECT

  mkdir "$TEST_PROJECT/bin"
  mkdir "$TEST_PROJECT/results"
  echo "dummy" > "$TEST_PROJECT/results/notebook.html"
  cd "$TEST_PROJECT/bin"

}

teardown() {
  cd -
  rm -rf ./tmp/test_client
}

@test "createRscriptFile.Create unexistent Rmd file" {

  run igor -c rmd test
  assert_success

  run ls .
  assert_output --partial "test.Rmd"

}

@test "createRscriptFile.Do not allow create two times same file" {

  run igor -c rmd test
  assert_success

  run igor -c rmd test
  assert_failure



}
