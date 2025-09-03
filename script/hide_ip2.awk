NR==1 {
  for(i=1;i<=NF;i++) {
    if($i=="dstip") dstip_col=i
    if($i=="srcip") srcip_col=i
  }
  print
  next
}
{
  if(!($dstip_col in dstip_map)) {
    dstip_map[$dstip_col]=sprintf("IP%010d", ++dstip_id)
  }
  if(!($srcip_col in srcip_map)) {
    srcip_map[$srcip_col]=sprintf("IP%010d", ++srcip_id)
  }
  $dstip_col=dstip_map[$dstip_col]
  $srcip_col=srcip_map[$srcip_col]
  print
}
