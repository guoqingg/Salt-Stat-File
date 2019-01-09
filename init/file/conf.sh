{%- from "init/map.jinja" import init with context -%}
export HISTTIMEFORMAT=" %F %T "
echo "#$(date +%s)" >> .bash_history
echo '{{ init.login_split }}' >> ~/.bash_history
