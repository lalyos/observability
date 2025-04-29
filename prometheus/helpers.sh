
alias r="source $BASH_SOURCE"

open_prom() {
  open "http://localhost:9090/query?g0.expr=coffee_cups_total&g0.show_tree=0&g0.tab=graph&g0.range_input=15m&g0.res_type=auto&g0.res_density=medium&g0.display_mode=lines&g0.show_exemplars=0&g1.expr=coffee_temp_celsius&g1.show_tree=0&g1.tab=graph&g1.range_input=1h&g1.res_type=auto&g1.res_density=medium&g1.display_mode=lines&g1.show_exemplars=0&g2.expr=brain_cpu_usage_percent&g2.show_tree=0&g2.tab=graph&g2.range_input=1h&g2.res_type=auto&g2.res_density=medium&g2.display_mode=lines&g2.show_exemplars=0"
}

push_coffee_loop() {
  : ${FLOOR:? required}
  for i in $(seq 1 ${1:-600}); do 
    push_coffee_metrics
    sleep 15
  done
}

push_coffee_metrics() {
  local job_name="coffee_demo"
  local pushgateway_url="http://localhost:9091/metrics/job/${job_name}/floor/${FLOOR:? required}/user/${USER}"

  : ${COFFEE_CUPS_TOTAL:=0}
  : ${COFFEE_CUPS_DECAF_TOTAL:=0}

  COFFEE_CUPS_TOTAL=$(( COFFEE_CUPS_TOTAL + $(( RANDOM % 10 + 1 )) ))
  COFFEE_CUPS_DECAF_TOTAL=$(( COFFEE_CUPS_DECAF_TOTAL + $(( RANDOM % 3 + 1 )) ))

  local coffee_temp=$(( RANDOM % 46 + 50 )) # 50 to 95
  local brain_usage=$(( RANDOM % 11 + 40 )) # 40 to 50

  cat <<EOF | curl --data-binary @- "${pushgateway_url}"
coffee_cups_total{decaf="false"} ${COFFEE_CUPS_TOTAL}
coffee_cups_total{decaf="true"} ${COFFEE_CUPS_DECAF_TOTAL}
coffee_temp_celsius ${coffee_temp}
brain_cpu_usage_percent ${brain_usage}
EOF

  echo "Pushed: coffee=${COFFEE_CUPS_TOTAL}, decaf=${COFFEE_CUPS_DECAF_TOTAL} coffee_temp_celsius=${coffee_temp}°C, brain_cpu_usage_percent=${brain_usage}%"
}

