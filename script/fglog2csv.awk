BEGIN{
  NTN = split("date,time,proto,srcip,srcport,dstip,dstport,service,srcintf,dstintf,srccountry,dstcountry,type,subtype,eventtype,level,severity,action,policyid,policytype,policyname,attack,ref,msg,sentbyte,rcvdbyte,sentpkt,rcvdpkt,appcat,crscore,craction,crlevel", TagName, ","); # 残したいところ
  for(i = 1; i < NTN; i++) printf("%s,", TagName[i]);  #Print Column Name
  printf("%s\n", TagName[i]);
  for(i = 1; i <= NTN; i++) D[TagName[i]] = "";  #Initialize D
  NITN = split("devname,devid,eventtime,tz,logid,vd,srcintfrole,dstintfrole,sessionid,poluuid,trandisp,duration,count,attackid", IgnoreTagName, ","); # 無視したいところ
}
{
  for(i = 5; i <= NF; i++) {  #Ignore Month, Date, Time, Hostname
    n = split($i, t, "=");
    if ((t[2] ~ /^".+"$/) || (t[2] !~ /"/)) {
    } else  #for Double Quoted Data which Include Space
      do {
        i++;
        t[2] = t[2]" "$i;
      } while ($i !~ /.+"$/);
    if (t[1] in D) D[t[1]] = t[2];  #1 Known TagName
    else {
      for(j = 1; j <= NITN; j++) if (t[1] == IgnoreTagName[j]) break;  #2 Known IgnoreTagName
      if (j > NITN) {  #3 New TagName
        NTN++;
        TagName[NTN] = t[1];
        D[TagName[NTN]] = t[2];
      }
    }
  }
  if (NF != 0) {
    for(i = 1; i < NTN; i++) {printf("%s,", D[TagName[i]]); D[TagName[i]] = "";}  #Print Data and Initialize D for Next Row
    printf("%s\n", D[TagName[i]]); D[TagName[i]] = "";
  }
}
END{
  for(i = 1; i < NTN; i++) printf("%s,", TagName[i]);  #Print Initialized and Added Column Name
  printf("%s\n", TagName[i]);
}
