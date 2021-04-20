# Bundler shortcuts
# via http://ryan.mcgeary.org/2011/02/09/vendor-everything-still-applies/
alias b="bundle"
alias bi="b install"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && bil && echo '.bundle/' >> .gitignore && echo 'vendor/cache/' >> .gitignore"


# For use with Chef
alias bebvv='bundle exec berks vendor vendor --delete'
