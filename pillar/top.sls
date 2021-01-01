---
base:
  'backyard.pup.haus':
    - groups.mailserver
    - hosts.backyard

  'himbo.hive.gateway':
    - groups.mailserver-files
    - hosts.himbo

  'util1.ptzo.gdn':
    - groups.mailserver
    - hosts.util1

  'uwu.krazy.party':
    - hosts.uwu
