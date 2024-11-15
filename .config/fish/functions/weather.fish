function weather --description '天气怎样？'
    set location (string escape --style=url "$argv")
    echo "http://wttr.in/$location"
    curl "http://wttr.in/$location"
end
