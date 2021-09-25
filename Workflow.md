


## Updating the repository to follow the ehterpad upstream


Example

     git checkout -b 1.8.13
     <edit> Dockerfile
     <edit> README.md 
     git commit -m "Etherpad 1.8.13" Dockerfile
     git tag 1.8.13
     docker build -t kolkman/etherpad_persistent:1.8.13
     docker push olkman/etherpad_persistent:1.8.13  # depends on being logged in.
     git push origin --tags
     git checkout master
     