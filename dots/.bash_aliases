alias dos2unix=fromdos
alias unix2dos=todos
alias unat='xmodmap -e "keycode 24 = q Q at at at at"'
alias gb='setxkbmap -layout gb'
alias unstick='xdotool key --clearmodifiers keyup Control_L keyup Control_R keyup Shift_L keyup Shift_R keyup Super_L keyup Meta_L keyup Meta_R'
function ifgem() {
  if [ -f Gemfile ]; then bundle exec $*; else $*; fi
}
alias rake="ifgem rake"
alias rackup="ifgem rackup"
alias shotgun="ifgem shotgun"
alias rspec="ifgem rspec"
alias irb="ifgem irb"
alias ruby="ifgem ruby"
alias cucumber="ifgem cucumber"
alias prmpt="PS1='$ '"
alias renet='(cd ~; killall nm-applet; nohup nm-applet >& /dev/null &)'
if [ -f ~/bin/hub ]; then
   alias git=hub
   [ -f ~/bin/hub.bash_completion.sh ] && . ~/bin/hub.bash_completion.sh
fi
# alias spring='java ${JAVA_OPTS} -jar ~/dev/bootstrap/bootstrap/spring-cli/target/spring-cli-0.5.0.BUILD-SNAPSHOT'
alias scale='gsettings set com.canonical.Unity.Interface text-scale-factor'
alias clear="echo -ne '\033c'"

# useful for terminal demos where the service returns unterminated content
alias jcurl='\curl -H "Accept: application/json"'
alias jjcurl='\curl -H "Accept: application/json" -H "Content-Type: application/json"'
function curl() {
   local args=();
   local flags=();
   local text;
   while [ "$1" != "" ]; do
       if [ "$1" = "--text" ]; then
           flags+=( -H Content-Type:text/plain);
           text=$1;
       elif [ "$1" = "--json" ]; then
           flags+=(-H Accept:application/json -H Content-Type:application/json);
           text="--text";
       else
           args+=("$1")
       fi
       shift;
   done
   if [ "$text" = "--text" ]; then
       /usr/bin/curl -w '\n' "${flags[@]}" "${args[@]}"
   else
       /usr/bin/curl "${flags[@]}" "${args[@]}"
   fi
}

function java9() {
         export JAVA_HOME=~/Programs/jdk1.9.0
         export JAVA_OPTS="-Xmx1024m -XX:CICompilerCount=1 -XX:TieredStopAtLevel=1 -Djava.security.egd=file:/dev/./urandom"
         export ANT_OPTS=$JAVA_OPTS
         export MAVEN_OPTS=$JAVA_OPTS
         export PATH=${PATH/jdk1.?.0/jdk1.9.0}
}

function java8() {
         export JAVA_HOME=~/Programs/jdk1.8.0
         export JAVA_OPTS="-Xmx1024m -XX:CICompilerCount=1 -XX:TieredStopAtLevel=1 -Djava.security.egd=file:/dev/./urandom"
         export ANT_OPTS=$JAVA_OPTS
         export MAVEN_OPTS=$JAVA_OPTS
         export PATH=${PATH/jdk1.?.0/jdk1.8.0}
}

function java7() {
         export JAVA_HOME=~/Programs/jdk1.7.0
         export JAVA_OPTS="-Xmx1024m -XX:MaxPermSize=256m -XX:CICompilerCount=1 -XX:TieredStopAtLevel=1 -Djava.security.egd=file:/dev/./urandom"
         export ANT_OPTS=$JAVA_OPTS
         export MAVEN_OPTS=$JAVA_OPTS
         export PATH=${PATH/jdk1.?.0/jdk1.7.0}
}

function mvn {
         dir=`pwd`
         while [ -e $dir/pom.xml ] && ! [ -e $dir/mvnw ] && ! [ -z $dir ]; do dir=${dir%/*}; done
         if [ -e $dir/mvnw ]; then
              echo "Running wrapper at $dir"
              $dir/mvnw "$@"
              return $?
         fi
         echo No wrapper found, running native Maven
         `which mvn` "$@"
}

function gradle {
         dir=`pwd`
         while [ "$dir/*.gradle" != "" ] && ! [ -e $dir/gradlew ] && ! [ -z $dir ]; do dir=${dir%/*}; done
         if [ -e $dir/gradlew ]; then
              echo "Running wrapper at $dir"
              $dir/gradlew "$@"
              return $?
         fi
         echo No wrapper found, locating native Gradle
         if ! which gradle; then
           echo No native gradle found && return 1
         fi        
         `which gradle` "$@"
}
