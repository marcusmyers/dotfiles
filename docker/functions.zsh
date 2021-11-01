function dmset() {
 eval $(dm env $1)
}

function dmunset() {
  eval $(dm env --unset)
}
