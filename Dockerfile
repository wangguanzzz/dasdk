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
RUN yum groupinstall -y “Development Tools”
