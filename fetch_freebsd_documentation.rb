#!/usr/bin/env ruby

# option section

# function option package
def create_package_source()
    system("tar cvzf bundle_source_fetch_freebsd_documentation.tgz README *.sh *.rb")
end

def create_package_documentation()
    system("tar cvzf bundle_documentation_fetch_freebsd_documentation.tgz articles books")
end

# end function option package

# see usage getoptlong.rb
require 'getoptlong'

# specify the options we accept and initialize
opts = GetoptLong.new(
                      [ "--help",    "-h", GetoptLong::NO_ARGUMENT],
                      [ "--version", "-V", GetoptLong::NO_ARGUMENT],
                      [ "--package", "-p", GetoptLong::REQUIRED_ARGUMENT]
)

help = "\n
NAME \n
  fetch_freebsd_documentation - fetch for offline usage freebsd single handbooks and articles documentations \n
\
SYNOPSIS \n
  offline_freebsd_documentation [-h|-V] \n
  offline_freebsd_documentation [-p [source|documentation]] \n
\
DESCRIPTION \n
  offline_freebsd_documentation is a tool to fetch freebsd single handbooks and articles documentations. \n
\
OPTIONS \n
  -h/--help \n
  usage help \n
\
  -V/--version \n
  displays the offline_freebsd_documentation version \n
\
  -p/--package \n
\n
"
version = "2011-08-11"

opts.each do | opt, arg |
  case opt
    when '--help' || '-h'
      puts help
      exit
    when '--version' || '-V'
    puts "version #{version}"
    exit
    when '--package' || '-p'
      puts "option package"
      if arg == 'source' then
        puts "argument #{arg}"
        create_package_source()
      end
      if arg == 'documentation' then
        puts "argument #{arg}"
        create_package_documentation()
      end
    exit
    else
      puts "Please read help manual"
      puts help
    end
end

# end option section

puts
puts "Download freebsd single handbooks and articles for static use"
puts

# variable definition
SITE = "ftp://ftp.au.FreeBSD.org/pub/FreeBSD/doc/en"

SECTION_TYPE_BOOK = "books"

SECTION_TYPE_ARTICLE = "articles"

# handbook
SUBSECTIONS_HANDBOOK = ["arch-handbook", "corp-net-guide", "design-44bsd", "dev-model", \
"developers-handbook", "faq", "fdp-primer", "handbook", "pmake", "porters-handbook"]

BOOK_HTML_TAR_BZ2 = "book.html.tar.bz2"

# article
SUBSECTIONS_ARTICLE = ["5-roadmap", "bsdl-gpl", "building-products", "casestudy-argentina.com", \
"checkpoint", "committers-guide", "compiz-fusion", "console-server", "contributing", \
"contributing-ports", "contributors", "cups", "custom-gcc", "cvs-freebsd", "cvsup-advanced", \
"dialup-firewall", "diskless-x", "euro", "explaining-bsd", "fbsd-from-scratch", "filtering-bridges", \
"fonts", "formatting-media", "freebsd-questions", "freebsd-update-server", "geom-class", \
"gjournal-desktop", "hats", "hubs", "ipsec-must", "laptop", "ldap-auth", "linux-comparison", \
"linux-emulation", "linux-users", "mailing-list-faq", "mh", "multi-os", "nanobsd", "new-users", \
"p4-primer", "pam", "portbuild", "pr-guidelines", "problem-reports", "pxe", "rc-scripting", "relaydelay", \
"releng", "releng-packages", "remote-install", "serial-uart", "solid-state", "storage-devices", \
"version-guide" , "vinum", "vm-design", "wp-toolbox", "zip-drive"]

ARTICLE_HTML_TAR_BZ2 = "article.html.tar.bz2"

SUBSHELL = "./freebsd_single_handbook_article_for_ruby.sh"
# end variable definition

# function declaration global fetch download

# purge directory structure
def clean_directory_structure(section_type,subsection)
  puts
  puts "purge directory structure of #{section_type}"
  puts
  # make empty directory
  subsection.each do |subsection_word|
    if File.directory?("#{section_type}/#{subsection_word}") then Dir.rmdir("#{section_type}/#{subsection_word}") end
  end
  # delete section_type directory
  if File.directory?("#{section_type}") then Dir.rmdir("#{section_type}") end
end

# create directory structure
def create_directory_structure(section_type,subsection)
  puts
  puts "create directory structure of #{section_type}"
  puts
  if !File.directory?("#{section_type}") then Dir.mkdir("#{section_type}",0744) end
  subsection.each do |subsection_word|
    if !File.directory?("#{subsection_word}") then Dir.mkdir("#{section_type}/#{subsection_word}",0744) end
  end
end

# fetch ftp download and extract archive
def fetch_download(site,section_type,subsection,package_type)
  subsection.each do |subsection_word|
    # creation of url	
    links = "#{site}/#{section_type}/#{subsection_word}/#{package_type}"
    puts " "
    puts "#{links}"
    puts " "
    # fetch ftp and extract archive . specific shell is used
    puts "shell running ..."
    command_line = "#{SUBSHELL} #{site} #{section_type} #{subsection_word} #{package_type}"
    puts "#{command_line}"
    system("#{command_line}")
  end
end

# end funtion declaration global fetch download

# global fetch download

# handbook
clean_directory_structure(SECTION_TYPE_BOOK,SUBSECTIONS_HANDBOOK)
create_directory_structure(SECTION_TYPE_BOOK,SUBSECTIONS_HANDBOOK)

# article
clean_directory_structure(SECTION_TYPE_ARTICLE,SUBSECTIONS_ARTICLE)
create_directory_structure(SECTION_TYPE_ARTICLE,SUBSECTIONS_ARTICLE)

# process download
# handbook
fetch_download(SITE,SECTION_TYPE_BOOK,SUBSECTIONS_HANDBOOK,BOOK_HTML_TAR_BZ2)
# article
fetch_download(SITE,SECTION_TYPE_ARTICLE,SUBSECTIONS_ARTICLE,ARTICLE_HTML_TAR_BZ2)

# global fetch download


