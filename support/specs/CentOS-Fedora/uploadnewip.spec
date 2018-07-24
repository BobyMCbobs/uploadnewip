Name:           uploadnewip
Version:        2.2
Release:        1%{?dist}
Summary:        Upload new dynamic public IP address of a GNU/Linux server to Dropbox every time it changes.
BuildArch:	noarch
License:        GPLv3
URL:            https://gitlab.com/BobyMCbobs/%{name}
Source0:        https://gitlab.com/BobyMCbobs/%{name}/-/archive/%{version}/%{name}-%{version}.zip
Requires:       curl


%description
Upload new dynamic public IP address of a GNU/Linux server to Dropbox every time it changes.


%prep
%autosetup


%install
%{__make} DESTDIR=$RPM_BUILD_ROOT install


%files
%license LICENSE
%doc README.md LICENSE
/usr/bin/%{name}
/usr/share/bash-completion/completions/%{name}
/etc/systemd/system/%{name}.service
/etc/%{name}/%{name}-blank.conf
/etc/%{name}/%{name}-settings.conf
/var/log/uploadnewip.log


%preun
systemctl disable %{name}
systemctl stop %{name}


%post
mkdir -p /etc/uploadnewip/units
mkdir -p /var/cache/uploadnewip/temp


%postun
rm -rf /etc/uploadnewip
rm -rf /var/cache/uploadnewip


%changelog
* Fri May 25 2018 caleb
- Init to RPM

