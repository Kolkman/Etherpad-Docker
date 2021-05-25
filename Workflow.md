


## Updating the repository to follow the ehterpad upstream


Example

     git checkout -b 1.8.13
     emacs -nw Dockerfile
     git commit -m "Etherpad 1.8.13" Dockerfile
     git tag 1.8.13
     git push origin --tags
     git checkout master