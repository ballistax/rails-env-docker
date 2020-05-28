alias be="bundle exec"
alias checkdev="git checkout develop"
alias pulldev="git pull origin develop"

function run(){
  if [ -n "$1" ]; then
    if [ $1 = "serve" ] || [ $1 = "s" ]; then
      bundle exec rails s -b 0.0.0.0
    elif [ $1 = "console" ] || [ $1 = "c" ]; then
      bundle exec rails c
    elif [ $1 = "reek" ]; then
      bundle exec reek
    elif [ $1 = "best" ]; then
      bundle exec rails_best_practices
    elif [ $1 = "fix" ]; then
      bundle exec standardrb --fix
    else
      echo "Unknow command"
    fi
  else
    echo "Unknow command"
  fi
}