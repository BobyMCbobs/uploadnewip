Name:           uploadnewip
Version:        2.2
Release:        1%{?dist}
Summary:        Server public IP uploader
BuildArch:	noarch
License:        GPL-3.0
URL:            https://gitlab.com/BobyMCbobs/%{name}
Source0:        https://gitlab.com/BobyMCbobs/%{name}/-/archive/%{version}/%{name}-%{version}.zip
Requires:       curl, bash, nano, iputils
BuildRequires:	unzip
BuildRequires:	systemd
%{?systemd_requires}


%description
Upload new dynamic public IP address of a GNU/Linux server to Dropbox every time it changes.


%prep
%autosetup


%install
%{__make} DESTDIR=$RPM_BUILD_ROOT install


%files
%license LICENSE
%doc README.md
%config /etc/%{name}/%{name}-blank.conf
%config /etc/%{name}/%{name}-settings.conf
%dir /etc/%{name}
%dir /etc/%{name}/units
%dir /usr/lib/systemd/system/
/usr/bin/%{name}
/usr/share/bash-completion/completions/%{name}
/usr/lib/systemd/system/%{name}.service
/var/log/%{name}.log


%pre
%service_add_pre %{name}.service


%preun
%systemd_preun %{name}.service


%post
%service_add_post %{name}.service
touch /var/log/%{name}.log


%postun
%service_del_postun %{name}.service
rm /var/log/%{name}.log


%changelog
* Fri May 25 2018 caleb
- Init to RPM

