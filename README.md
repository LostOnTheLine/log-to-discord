# log-to-discord
A Docker Container to send selected logtails to a Discord Webhook

```yaml
version: '3'
services:
  log-to-discord:
    #image: ghcr.io/lostontheline/log-to-discord:latest
    image: lostontheline/log-to-discord:latest
    container_name: log-to-discord
    user: 1000:1000
    environment:
      PUID: 1000 #optional
      PGID: 1000 #optional
      LOG_FILE: /var/log/sample.log #Comma separated list if multiple files "/var/log/sample.log,/var/log/sample log file.txt,/var/log/my container/logfile.log"
      DISCORD_WEBHOOK: "https://discord.com/api/webhooks/your-webhook-url"
      #FILTER_BY_WORD: "error"
    volumes:
      - /docker/log/var/log:/var/log:rw
      - /etc/localtime:/etc/localtime:ro
      - /etc/timezone:/etc/timezone:ro
    restart: always
    #security_opt:
    #  - no-new-privileges:true
    labels:
      - "com.centurylinklabs.watchtower.scope=dockerhub"
    #  - "com.centurylinklabs.watchtower.scope=github"
```

This container is designed to run as a non-root user

I have a label for Watchtower, that can obviously be removed or edited to your own needs. 

## ENVIRONMENT VARIABLES

### LOG_FILE:    
 - - - #### Comma-separated list, without spaces, of files to livetail. If your directories or filenames have spaces you will need to include `" "` around the list
 - - - ###### e.g. LOG_FILE: "/var/log/sample.log,/var/log/sample log file.txt,/var/log/my container/logfile.log"
 - - - ###### e.g. LOG_FILE: "/var/log/sample log file.txt"
 - - - ###### e.g. LOG_FILE: /var/log/sample.log
 - - - #### If multiple files are used it will show the name each time it is different from the last message
```
==> /var/log/sample.log <==
2023-03-20 @ 00:37:00
==> /var/log/cron.log <==
crond: wakeup dt=60
```
### DISCORD_WEBHOOK:    
 - - - #### To send notifications to a channel go into the channel & `Edit Channel`
 - - - #### Select `Integrations`
 - - - #### Select `Webhooks`
 - - - #### Create a `New Webhook`
 - - - #### Go into the webhook settings & give it a name, avatar, whatever you like. Then click `Copy Webhook URL`
 - - - #### Paste that URL in the compose
 - ###### If the webhook URL is not reachable the container will show as `Unhealthy`
### FILTER_BY_WORD:    
 - - - #### If you only want to send lines that have the word "error" or "taco" in them you can specify that here. 
 - - - #### If nothing is set it will include every new line added to the file after the container started.
 - - - ###### e.g. FILTER_BY_WORD: "error"
 - - - ###### e.g. FILTER_BY_WORD: "2023"
 - - - ###### e.g. FILTER_BY_WORD: "complete"
 - - - ###### e.g. FILTER_BY_WORD: "taco"


-----
-----
-----

I have included the `image:` calls for both Docker Hub & ***(commented out)*** for this GitHub Package. 
As it looks nicer, sorts nicer, & is easier to upload & manage, the Docker Hub one is my preferred method & will always get updated 1st, but I'll try to make sure this one happens right after & any changes are updated here. 
