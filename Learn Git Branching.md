# Learning Git Branching

## Main

### 1.1 Introduction to Git Commits
```
git commit;
git commit;
```

### 1.2 Branching in Git
```
git branch bugFix;
git checkout bugFix;
```

### 1.3 Merging in Git
```
git checkout -b bugFix;
git commit;
git checkout master;
git commit;
git merge bugFix;
```

### 1.4  Rebase Introduction
```
git checkout -b bugFix;
git commit;
git checkout master;
git commit;
git checkout bugFix;
git rebase master;
```

### 2.1 Detach yo’ HEAD
```
git checkout C4;
```

### 2.2 Relative refs (^)
```
git checkout C4^;
```

### 2.3 Relative refs #2 
```
git branch -f master C6;
git branch -f bugFix C0;
git checkout C1;
```

### 2.4 Reversing Changes in Git
```
git reset local~1;
Elimina todos los commit desde HEAD hasta  el commit equivalente a local~1 (sin eliminar local~1)
Hay que tener cuidado ya que cuando se borran dichos commit, los archivos quedan con la version del commit eliminado, no se va directamente a la version del ultimo commit (local~1) de la rama. Para solucionar esto hacemos git restore . (el punto funciona como un *)
 
git checkout pushed;

git revert pushed;
Luego de hacer el revert hacer git add . y git revert --continue.
Una consideración importante es que al ejecutar git revert "hash-commit", se realiza un merge entre el commit anterior a hash-commit y el HEAD.

pushed es una rama remota
```

### 3.1 Cherry-pick Intro
```
git cherry-pick C3 C4 C7;
```

### 3.2 Interactive Rebase Intro
```
git rebase -i overHere;

si hago git rebase -i C3:
1. Si c3 es un ancestro de donde estoy parado, se toman todos los commit desde donde estoy parado hasta c3.
2. Si c3 esta en otra rama, se toman todos los commit desde donde estoy parado hatsa el commit donde se genera la bifurcacion que da lugar a las dos ramas 

```
*For the solution, order the commits as C3, C5, C4. You may need to omit or pick commits.*

### 4.1 Grabbing Just 1 Commit
```
git checkout master;
git cherry-pick C4;
```

### 4.2 Juggling Commits
```
git rebase -i caption~2;
git commit --amend;
git rebase -i caption~2;
git branch -f master caption;
```
*1) For the solution, order the commits as C3, C2. You may need to omit or pick commits.*

*2) For the solution, order the commits as C2'', C3'. You may need to omit or pick commits.*

### 4.3 Juggling Commits #2
```
git checkout master;
git cherry-pick C2;
git commit --amend;
git cherry-pick C3;
```

### 4.4 Git Tags
```
git tag v0 C1;
git tag v1 C2;
git checkout C2;
```

### 4.5 Git Describe
```
git commit;
```

### 5.1 Rebasing over 9000 times
```
git rebase master bugFix;
en master pone la rama bugFix
git rebase bugFix side;
git rebase side another;
git rebase another master;
```

### 5.2 Multiple parents
```
git branch bugWork master~^2~;
```

### 5.3 Branch Spaghetti
```
git checkout one;
git cherry-pick C4 C3 C2;
git checkout two;
git cherry-pick C5 C4 C3 C2;
git branch -f three C2;
```

## Remote


### 1.1 Clone Intro
```
git clone;
```

### 1.2 Remote Branches
```
git commit;
git checkout o/master;
git commit;
```

### 1.3 Git Fetchin’
```
git fetch;
```

### 1.4 Git Pullin’
```
git pull;
```

### 1.5 Fakeing Teamwork
```
git clone;
git fakeTeamwork master 2;
git commit;
git pull;
```

### 1.6 Git Pushin’
```
git clone;
git commit;
git commit;
git push;
```

### 1.7 Diverged History
```
git clone;
git fakeTeamwork;
git commit;
git pull --rebase;
git push;
```

### 2.1 Push Master!
```
git fetch;
git rebase o/master side1;
git rebase side1 side2;
git rebase side2 side3;
git rebase side3 master;
git push;
```

### 2.2 Mering with remotes
```
git checkout master;
git pull;
git merge side1;
git merge side2;
git merge side3;
git push;
```

### 2.3 Remoting Tracking
```
git checkout -b side o/master;
git commit;
git pull --rebase;
git push;
```

### 2.4 Git push arguments
```
git push origin master;
git push origin foo;
```

### 2.5 Git push arguments — Expanded!
```
git push origin master~1:foo;
git push origin foo:master;
```

### 2.6 Fetch arguments
```
git fetch origin master~1:foo;
git fetch origin foo:master;
git checkout foo;
git merge master;
```

### 2.7 Source of nothing
```
git push origin :foo;
git fetch origin :bar;
```
### 2.8 Pull arguments
```
git pull origin bar:foo;
git pull origin master:side;
```


-----

`learn-git-branching-solution` `learn-git-branching-main`  `learn-git-branching-remote` `learn git branching solution` `learn git branching main`  `learn git branching remote` 

