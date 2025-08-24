# Login Function
function oplogin() { eval $(op signin); }

# Source op completion
source <(op completion zsh)

alias ovl="op vault list $@"

# op --format json item list --tags "Share-common2","LastPass 2 Import 2024-12-07 10:20 AM"
# op item delete --archive "4ifvuu4otslnngwnmls3gllnre"
# op item delete  "4ifvuu4otslnngwnmls3gllnre"
# cat id2delete.txt|while read id; do\njq -r ".[]|select(.id==\"\").title" lpass2.json\nop item delete ; done
# op --format json item list --tags "LastPass 2 Import 2024-12-07 10:20 AM","Share Common" |jq  -r '[.[]|select(.tags|contains(["Share-Common"]))]|length'
