# Give Username to variable here
$User = RendsolveGaming

# Assigns a password variable via Your Input
$Password = Read-Host -AsSecureString

# Creates new user
New-LocalUser $User -Password $Password -FullName "Rensolve Gaming" -Description "Rendsolve Gaming Account."

# Adds newly created user to Admins
Add-LocalGroupMember -Group "Administrators" -Member $User
