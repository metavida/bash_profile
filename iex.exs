# Tell iex to not render lists of ints as a charlist
# https://stackoverflow.com/questions/40324929/integer-list-printed-as-string-in-elixir
IEx.configure inspect: [charlists: false]
