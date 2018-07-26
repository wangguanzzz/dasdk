FROM consol/centos-xfce-vnc
MAINTAINER chris wang
USER root
ADD https://download.sublimetext.com/sublime_text_3_build_3176_x64.tar.bz2 /opt/sublime.tar
RUN cd /opt/ && tar xvf /opt/sublime.tar  && ln -s  /opt/sublime_text_3/sublime_text /usr/bin/subl && rm -f /opt/sublime.tar
RUN wget -c "https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm" -O /tmp/epel-release-latest-7.noarch.rpm && rpm -Uvh /tmp/epel-release-latest-7.noarch.rpm || echo 0
RUN wget -c "https://centos7.iuscommunity.org/ius-release.rpm" -O /tmp/ius-release.rpm && sudo rpm -Uvh /tmp/ius-release.rpm
RUN rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
RUN rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
RUN yum-config-manager --enable elrepo-extras elrepo-kernel && yum makecache && yum -y update
RUN yum groups mark install "Development Tools" && yum groups mark convert "Development Tools" && yum groupinstall -y "Development Tools" 
RUN yum remove -y `rpm -qa git\*` subversion
RUN yum install -y openssl-devel.x86_64 bzip2-devel.x86_64x readline-devel.x86_64 sqlite-devel.x86_64 tk-devel.x86_64 libpng-devel.x86_64 freetype-devel.x86_64 curl.x86_64 git2u.x86_64
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
ADD bashrc /headless/.bashrc
RUN source ~/.bashrc && pyenv install 3.6.3 && pyenv global 3.6.3
RUN yum install -y java-1.8.0-openjdk-devel && yum clean all
RUN wget -c "https://downloads.lightbend.com/scala/2.12.6/scala-2.12.6.rpm" -O /tmp/scala-2.12.6.rpm && sudo rpm -Uvh /tmp/scala-2.12.6.rpm
RUN curl  https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo
RUN yum makecache
RUN yum install -y sbt

