# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.27
# 

Name:       harbour-saber-im

# >> macros
# << macros

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary:    A Collection Of Chinese Input Method Powered By SK_Work, Behold & Saber Altria.
Version:    0.9
Release:    8
Group:      Qt/Qt
License:    LICENSE
URL:        http://www.saberaltria.co.uk/
Source0:    %{name}-%{version}.tar.bz2
Source100:  harbour-saber-im.yaml
Requires:   sailfishsilica-qt5 >= 0.10.9
BuildRequires:  pkgconfig(sailfishapp) >= 1.0.2
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  desktop-file-utils

%description
A Collection Of Chinese Input Method Powered By SK_Work, Behold & Saber Altria.


%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
# << build pre

%qtc_qmake5 

%qtc_make %{?_smp_mflags}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%qmake5_install

# >> install post
# << install post

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop


%files
%defattr(755,nemo,nemo,755)
%{_datadir}/harbour-saber-im
/home/nemo/.config/SaberAltria/
%defattr(-,root,root,-)
%{_libdir}
%{_datadir}/maliit
/usr/bin/harbour-saber
%{_datadir}/harbour-saber
%{_datadir}/applications/harbour-saber.desktop
%{_datadir}/icons/hicolor/86x86/apps/harbour-saber.png
# >> files
# << files