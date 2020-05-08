alias be="bundle exec"
alias checkdev="git checkout develop"
alias pulldev="git pull origin develop"

function run(){
  if [ $1 = "serve" ]; then
    bundle exec rails s -b 0.0.0.0
  elif [ $1 = "console" ]; then
    bundle exec rails c
  elif [ $1 = "reek" ]; then
    bundle exec reek
  elif [ $1 = "best" ]; then
    bundle exec rails_best_practices
  fi
}