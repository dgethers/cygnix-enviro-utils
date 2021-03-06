def abs:
  if type == "number"
  then
    if . >= 0
    then .
    else -.
    end
  else error("abs requires a number, got \(type)")
  end
;


def dec_places:
  if type == "number"
  then
    if ([(. - floor),  (. - (-. | -floor))] | map(abs) | min) < 0.00000001
    then 0
    else 1 + ((10 * .) | dec_places)
    end
  else error("dec_places input must be a number, got \(type)")
  end
;


def from_entries_multi:
    reduce .[] as $item (
        {} ;
        . + {
            ($item.key): (
                (
                     (.[($item.key)])//[]
                ) + [($item.value)]
            )
        }
    )
;
