#!/usr/bin/env bats
load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'


setup() {


  mkdir -p ./tmp/test_client

  cd ./tmp/test_client

  TODAY=`date +%Y%m%d`

}


teardown() {
  cd -
  rm -rf ./tmp/test_client
}



@test "create.Create empty project" {

  run igor -c project test

  assert_output --partial "Base folder structure created"

  run ls ./$TODAY.test/bin
  assert_success

  run ls ./$TODAY.test/data
  assert_success

  run ls ./$TODAY.test/doc
  assert_success

  run ls ./$TODAY.test/src/r
  assert_success

  run ls ./$TODAY.test/src/sh
  assert_success

  run ls ./$TODAY.test/results
  assert_success

}


@test "create.Create empty project fails when trying to create it again" {

  run igor -c project test2

  assert_output --partial "Base folder structure created"

  run igor -c project test2

  assert_failure

}
