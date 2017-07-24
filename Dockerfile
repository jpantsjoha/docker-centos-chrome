FROM centos:centos7

RUN yum -y update; yum clean all
RUN yum -y install mesa-dri-drivers libexif libcanberra-gtk2 libcanberra; yum clean all

ADD google-chrome-stable_current_x86_64.rpm /google-chrome-stable_current_x86_64.rpm
RUN yum -y install /google-chrome-stable_current_x86_64.rpm
RUN yum clean all
RUN rm /google-chrome-stable_current_x86_64.rpm

ADD requirements.txt /requirements.txt
RUN pip install -y -r /requirements.txt

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

CMD ["run.sh"]