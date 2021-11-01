bm_asana() {

  task_number_from_branch=`current_branch | awk -F '-' '{print$1}' | sed -e 's/[^0-9]*//'`

  case "$1" in
    "open")
      open `bm asana $2 url`
      ;;
    "link")
      bm asana $task_number_from_branch url
      ;;
    "open_branch")
      if [ ! -z $task_number_from_branch ]; then
        open `sqm asana $task_number_from_branch url`
      fi
      ;;
    "copy_branch")
      if [ ! -z $task_number_from_branch ]; then
        echo "Copying task #$task_number_from_branch to the clipboard";
        bm asana $task_number_from_branch url | xclip;
      fi
      ;;
    *)
      echo "usage: task <command>
      Commands:
      open          Opens the task # in your default browser.
      link          Outputs the link to the task.
      open_branch   Opens the link for the related task of the current branch.
      copy_branch   Copies the link to the clipboard for the related task of the current branch.
      "
      ;;

    esac
  }
# Function: start
#
# This function can be used to start work on an asana task.
# TODO: more documentation.
start() {
  branch_name=`git branch | grep $1 | awk '{print $1}'`

  if [[ $branch_name == "" ]]
  then
    remote_branch_name=`git branch -r | grep $1 | awk -F "/" '{print $2}'`
    if [[ $remote_branch_name == "" ]]
    then
      `bm asana $1`
    else
      git checkout -b $remote_branch_name origin/$remote_branch_name
    fi
  else
    git checkout $branch_name
  fi
}

# Function: finish
#
# This function can be used to finish work on an asana task.
# TODO: more documentation.
finish() {
  branch_name=`current_branch`

  if [[ $branch_name == "master" ]]
  then
    echo "Dude! -9001"
  else
    git push origin `current_branch`
    command="bm_asana"
    eval "$command copy_branch"
  fi
}
