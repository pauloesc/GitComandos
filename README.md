### 1.0 Comando util:
```
git config --global alias.map "log --all --decorate --oneline --graph"
```

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

git rebase master toma todos los commit (desde donde se genero la divergencia con master) de la rama donde estoy parado y lo manda a master.
git rebase hace una integracion (no se llama merge) por lo que se pueden generar conflictos
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
1. Si c3 es un ancestro de donde estoy parado (HEAD), se toman todos los commit desde donde estoy parado hasta c3 (sin incluir c3). El resultado del rebase sobrescribe la rama donde me encuentro.

2. Si c3 esta en otra rama, se toman todos los commit desde donde estoy parado hatsa el commit donde se genera la bifurcacion que da lugar a las dos ramas, y los pone sobre la rama a rebasar.

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

"git commit --amend" permite que los los ultimos cambios que realize se incorporen al commit ya existente, ademas permite modificar el comentario del commit existente.
COMO USARLO: luego de hacer cmabios en los archivos hayq ue hacer: 1) git add . 2) git commit --amend

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
<nombre del remoto>/<nombre de la rama>
```

```
git commit;
git checkout o/master (cuando trabajamos sobre una rama remota estamos en modo detached)
git commit;
```

### 1.3 Git Fetchin’

git fetch hace dos cosas:
1) Baja los commits que el remoto tiene pero no están en nuestro repositorio local, y...
2) Actualiza a dónde apuntan nuestras ramas remotas (por ejemplo, o/main)

Sin embargo, git fetch no modifica en absoluto tu estado local.
No va a actualizar tu rama main ni va a cambiar nada sobre cómo se ve tu sistema de archivos en este momento.
Es importante entender esto, ya que hay quienes piensan que correr git fetch hará que su estado local refleje el estado del remoto (y no es asi)

```
git fetch;
```

### 1.4 Git Pullin’

Para fetchear cambios remotos y después mergearlos usamos "git fetch", (hay que tener cuidado de en que rama estamos parados)(creo)

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

git push es el responsable de subir tus cambios a un remoto.

cuando hacemos "git push" nuestra rama remota se actualiza (cambia a donde esta el  HEAD).

```
git clone;
git commit;
git commit;
git push;
```

### 1.7 Diverged History

***si en la siguiente situacion hacemos git push no sucedera nada***.

![The San Juan Mountains are beautiful!](https://github.com/pauloesc/GitComandos/blob/main/imgagenes/1.png)

Imaginate que clonás un repositorio el lunes y empezás a desarrollar algo. Para el viernes tenés todo listo para publicar tu trabajo, pero, ¡oh, oh! Tus colegas también escribieron código durante la semana, haciendo que tu trabajo quede desactualizado (y obsoleto). Además, publicaron esos commits en el repositorio remoto, así que ahora tu trabajo está basado en una versión vieja del proyecto, que ya no le interesa a nadie.

En este caso, el comando git push es ambiguo. Si corrés git push, ¿git debería cambiar el repositorio a como estaba el lunes? ¿Debería tratar de agregar tu código sin eliminar el código nuevo? ¿O debería ignorar completamente tus cambios porque están desactualizados?

Como hay tanta ambiguedad en esta situación (en que la historia divirgió), git no te permite pushear tus cambios. En cambio, te fuerza a integrar el último estado del repositorio remoto antes de poder compartir tu trabajo.

Un posible solucion es:
+ git fetch (parado sobre main)
+ git rebase o/main
+ git push

¡git pull --rebase es un atajo para hacer fetch y rebase!

Otra posible solucion es:
+ git fetch (parado sobre main)
+ git merge o/main
+ git push

¡git pull es simplemente un atajo para hacer fetch y merge!

```
git clone;
git fakeTeamwork;
git commit;
git pull --rebase;
git push;
```

### 1.8 Main Bloqueado

```
git reset --hard o/main
git checkout -b feature C2
git push origin feature
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

Podés hacer que cualquier rama que quieras trackee o/main, y si lo hicieras, esa rama va a tener el mismo destino implícito de push y objetivo implícito de merge que main. Eso significa que podés correr git push en una rama llamada absolutamenteNoEsMain y ¡que tu trabajo se pushee a la rama main del remoto!

Hay dos formas de establecer esta propiedad. La primera es checkoutear una nueva rama usando una rama remota como la referencia especificada.

git checkout -b absolutamenteNoEsMain o/main

Crea una nueva rama llamada absolutamenteNoEsMain y la hace trackear a o/main.

Si haceos:
+ git checkout -b foo o/main; (esto nos deja sobre la rama foo)
+ git pull;  observar donde queda la rama main (la rama main no se actualizo)

![](https://github.com/pauloesc/GitComandos/blob/main/imgagenes/2.png)

Si hacemos:
+ git checkout -b foo o/main; (esto nos deja sobre foo)
+ git commit;
+ git push (en el remoto si se actualiza la rama main, de hecho foo no existe en el remoto)

El resultado deja los repositorios (local y remoto) como la foto de arriba.

Otra forma de especificar la rama a trackear es usar la opción git branch -u. Ejecutando git branch -u o/main foo.

```
git checkout -b side o/master;
git commit;
git pull --rebase;
git push;
```

### 2.4 Git push arguments

Aprendimos en la lección sobre ramas remotas que git determinó el remoto y la rama a la que pushear mirando las propiedades de la rama actual (el remoto al que "trackea").

-------------------------------

"git push origin main" se traduce así al español:

Andá a la rama "main" en mi repositorio, agarrá todos los commits, y después andá a la rama "main" del remoto llamado "origin". Aplicá ahí todos los commits que falten, y avisame cuando termines.

Especificando main como el parámetro "lugar", le dijimos a git de dónde traer los commits, y a dónde mandarlos. Es, básicamente, el "lugar" o "ubicación" que sincronizar entre ambos repositorios.

***Tené en cuenta que, como le dijimos a git todo lo que necesitaba saber (especificando ambos parámetros), ¡ignora totalmente dónde estamos parados en este momento¡***

```
git push <remoto> <lugar>
```

-------------------------------


```
git push origin master;
git push origin foo;
```

### 2.5 Git push arguments — Expanded!

En la lección anterior cuando especificamos main como el parámetro lugar de git push, especificamos tanto el origen del cual sacar los commits como el destino al cual enviarlos.


¿Y si quisiéramos que el origen y el destino sean distintos?

¿Si quisieras pushear los commits de la rama local foo a la rama bar del remote?

Para especificar tanto el origen como el destino de <lugar>, simplemente unilos usando dos puntos...
```
git push origin <origen>:<destino>
```


¿Y qué hay si el destino al que querés pushear no existe? Simplemente dale un nombre al branch y git se va a encargar de creártelo en el remoto. 
```
git push origin main:newBranch 
```
EL comando anterior deja los repos asi:

![](https://github.com/pauloesc/GitComandos/blob/main/imgagenes/3.png)


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

### resultados de consola 1

Observar que no es lo mismo (HEAD, nueva2) que (HEAD -> nueva2)

```
paulo@paulo-hp:~/Desktop/v5$ git map
* 2ea677a (master) kdsjnjnbdfbndfhv modificado 1 modificado dos con NuevaLinea
* fc3ab79 f
* 563c3d0 (HEAD) e
* 7fee8b5 d
* f100fda (nueva) c
* d30f106 b
* 50a2c24 a

paulo@paulo-hp:~/Desktop/v5$ git branch
* (HEAD detached at 563c3d0)
  master
  nueva

paulo@paulo-hp:~/Desktop/v5$ git branch nueva2
paulo@paulo-hp:~/Desktop/v5$ git map
* 2ea677a (master) kdsjnjnbdfbndfhv modificado 1 modificado dos con NuevaLinea
* fc3ab79 f
* 563c3d0 (HEAD, nueva2) e
* 7fee8b5 d
* f100fda (nueva) c
* d30f106 b
* 50a2c24 a

paulo@paulo-hp:~/Desktop/v5$ git checkout nueva2
Switched to branch 'nueva2'
paulo@paulo-hp:~/Desktop/v5$ git map
* 2ea677a (master) kdsjnjnbdfbndfhv modificado 1 modificado dos con NuevaLinea
* fc3ab79 f
* 563c3d0 (HEAD -> nueva2) e
* 7fee8b5 d
* f100fda (nueva) c
* d30f106 b
* 50a2c24 a
paulo@paulo-hp:~/Desktop/v5$ 
```



### resultados de consola 2

```
paulo@paulo-hp:~/Desktop/v5$ git map
* 2ea677a (master) kdsjnjnbdfbndfhv modificado 1 modificado dos con NuevaLinea
* fc3ab79 f
* 563c3d0 (HEAD -> nueva2) e
* 7fee8b5 d
* f100fda (nueva) c
* d30f106 b
* 50a2c24 a
paulo@paulo-hp:~/Desktop/v5$ git checkout f100fda
Note: switching to 'f100fda'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at f100fda c
```

### Resultado de consola 3
Uso de git switch -c

```
paulo@paulo-hp:~/Desktop/v5$ git map
* e64fa85 (HEAD) 111
| * 2ea677a (master) kdsjnjnbdfbndfhv modificado 1 modificado dos con NuevaLinea
| * fc3ab79 f
|/  
* 563c3d0 (nueva2) e
* 7fee8b5 d
* f100fda (nueva) c
* d30f106 b
* 50a2c24 a
paulo@paulo-hp:~/Desktop/v5$ git status
HEAD detached from 563c3d0
nothing to commit, working tree clean
paulo@paulo-hp:~/Desktop/v5$ git switch -c sol
Switched to a new branch 'sol'
paulo@paulo-hp:~/Desktop/v5$ git map
* e64fa85 (HEAD -> sol) 111
| * 2ea677a (master) kdsjnjnbdfbndfhv modificado 1 modificado dos con NuevaLinea
| * fc3ab79 f
|/  
* 563c3d0 (nueva2) e
* 7fee8b5 d
* f100fda (nueva) c
* d30f106 b
* 50a2c24 a

```



### Resulado de consola 4

Rebase

```
paulo@paulo-hp:~/Desktop/v6$ git map
* ace7c1e (HEAD -> rama1) dos
* fbccfa2 uno
| * 4fea6a7 (master) f
| * c24dd52 e
| * 3348cd5 d
| * 79f3252 c
| * bf86186 b
| * dbad89b a
|/  
* 846debe subi puntos
paulo@paulo-hp:~/Desktop/v6$ git rebase master
Successfully rebased and updated refs/heads/rama1.
paulo@paulo-hp:~/Desktop/v6$ git map
* bec7983 (HEAD -> rama1) dos
* b3b3af6 uno
* 4fea6a7 (master) f
* c24dd52 e
* 3348cd5 d
* 79f3252 c
* bf86186 b
* dbad89b a
* 846debe subi puntos

```



### Resulado de consola 5

Rebase, ¿que pasa si eliminamos un commit donde hay una bifurcacion?
* ¿que pasa si intentamos eliminar los commit "e" "d" "c"?

```
paulo@paulo-hp:~/Desktop/v6$ git map
* bd07e58 (HEAD -> rama3) rama33
| * ce7e165 (rama1) 4 mod
| * b08266e 2
| * 045a200 1
|/  
* c24dd52 (tag: hhh, master) e
* 3348cd5 d
* 79f3252 c
* bf86186 b
* dbad89b a
* 846debe subi puntos
paulo@paulo-hp:~/Desktop/v6$ 
paulo@paulo-hp:~/Desktop/v6$ 
paulo@paulo-hp:~/Desktop/v6$ git rebase -i bf86186
Successfully rebased and updated refs/heads/rama3.
paulo@paulo-hp:~/Desktop/v6$ git rebase -i bf86186
Successfully rebased and updated refs/heads/rama3.
paulo@paulo-hp:~/Desktop/v6$ git map
* c68c33b (HEAD -> rama3) rama33
| * ce7e165 (rama1) 4 mod
| * b08266e 2
| * 045a200 1
| * c24dd52 (tag: hhh, master) e
| * 3348cd5 d
| * 79f3252 c
|/  
* bf86186 b
* dbad89b a
* 846debe subi puntos
paulo@paulo-hp:~/Desktop/v6$ 
```
