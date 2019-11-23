#!/usr/bin/env bats
load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'


setup() {
  mkdir -p ./tmp/
  cd ./tmp/
}


teardown() {
  cd -
  rm -rf ./tmp/*
}



@test "createClient.Create new client" {

  run igor -c client test_client

  run ls ./test_client
  assert_success

}


@test "createClient.Create empty client fails when trying to create it again" {

  run igor -c client test_client

  run ls ./test_client
  assert_success

  run igor -c client test_client
  assert_failure



}
