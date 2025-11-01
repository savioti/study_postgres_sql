# SQL Security Best Practices

## Isolate the Database Server

Production database servers should be isolated as much as possible from other applications and services.

- operating systems should be lean, with only the necessary services installed and running
- putting your SQL server in a restricted network segment/VLAN so that only authorized traffic can pass to it
- only an application server or web server will be talking directly to the database
- never open your database server up to the internet on ports used by your database

## Tailor the DB Installation

Database systems offer several additional features, but most of them are not used very often. By removing what you don't need, you reduce the possibilities of exploitation.

## Keep your DB system updated

Database systems are regularly patched, so you should keep your version up to date. Doing so can prevent the majority of attacks, as most of the vulnerabilities exploited are known for over a year.

## Restrict SQL Traffic

By only allowing SQL traffic to and from designated IP addresses, you can be sure that a malicious actor or infected client inside the firewall doesn’t hammer away at your server.

## Use Least Privilege When Assigning Permissions

Database users, like users on any system, should only have as much access as they need to perform their duties, also known as the principle of least privilege.

Stay away from “ALL” grants in MySQL and sysadmin role membership in MSSQL if possible.

## Protect Against SQL Injection

When a web application accepts user input and sends it to the database, unsanitized data can “inject” malicious code into the server and perform unauthorized tasks, including getting full shell access, depending on the server’s configuration.

There’s really only one way to prevent them, and that’s to utilize stored procedures instead of direct SQL queries for webapp interaction.

Stored procedures only accept pre-established parameters and can only perform very specific functions, so they prevent the injection of data into a raw SQL query.

This has been best practice for many years now, but many production applications still run code with SQL vulnerabilities, one of the most commonly exploited vulnerabilities on the internet.
