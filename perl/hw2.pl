#                       CSC 123 Perl-Scheme Assignment
#                       Due one week from date assigned

# Nicholas Kumia
# CXC1X3 Programming Languages Assignment 2
# 10.03.2017

# --------------------  Part I. Perl Drills.    $%&\*@! --------------------

local $Z = "Question 0::";
#0. Euclid's algorithm for computing the gcd of two numbers can be
#   written in C as
#   int gcd(int a, int b) {if (a==0) return b; else return gcd(b%a,a);}
#
#   Write it in Perl twice, one recursively and one using a while loop.
#   Don't forget that the {}'s are required in if-else expressions.
#   Try to use Perl's unique features.  For example, in the while
#   loop version, you shouldn't have to use any temporary variables.
#   There's a very similar function in my tutorial that will provide
#   you with a hint as to what I mean.  Most of the operator symbols
#   such as % are the same as in C/Java.

# Recursive GCD Function
# If a = 0, return b;
# Otherwise, recursively do b%a until a == 0
sub gcd {
    if (@_[0]==0) { return @_[1]; }
    else { return gcd(@_[1]%@_[0], @_[0]); }
}

# While-loop GCD Function
# Define local a,b to keep global a,b unchanged
# Until a == 0, forever b%a
# Return b;
sub gcdW {
    my ($a, $b) = @_;
    while ($a != 0){
        ($a, $b) = ($b%$a, $a);
    }
    return $b;
}

print $Z, "The GCD (recursive) of (5,20) is ", gcd(5,20), "\n";
print $Z, "The GCD (while) of (15,20) is ", gcdW(15,20), "\n";



$Z = "Question 1::";
# 1.    Here's how I would implement a function "forall", which checks if all
#   elements of an array satisfies a boolean property, which is passed in
#   as a function:
sub forall
{
    my ($f,@A) = @_;    # first argument is the function, second is the array
    my $answer = 1; # default answer is true
    foreach my $x (@A)  # read: "for each element x in array A ..."
        { if (!($f->($x))) {$answer = 0;} }
    $answer;
}

# recursive version:
sub forall
{
    my ($f,@A) = @_;
    if (@A==()) {1}
    else { my ($carA,@cdrA) = @A;
             $f->($carA) & forall($f,@cdrA)
            }
}

# usage:
print $Z, "forall( sub{\$_[0]>0}, (3,5,-2,1,0,4) )", "\n";
print $Z, forall( sub{$_[0]>0}, (3,5,-2,1,0,4) ), ": is false because not all numbers in the list are positive\n";

# Now implement the complementary function "thereexists" which should return
# true if and only there is an element in the list that satisfies the property.

# Thereexists
# Define local function f, and array A to hold the data
# If the array is empty, return 0 (false)
# Otherwise check if the first element satisfies function
# 'OR' the result recursively with 'thereexists' on the rest of the list
sub thereexists {
    my($f,@A) = @_;
    if (@A==()) {0}
    else {
        my ($carA,@cdrA) = @A;
        $f->($carA) | thereexists($f,@cdrA);
    }
}


print $Z, "thereexists( sub{\$_[0]>0}, (3,5,-2,1,0,4) ), ", "\n";
print $Z, thereexists( sub{$_[0]>0}, (3,5,-2,1,0,4) ), ": is true because at least one of the numbers in the list are positive\n";



$Z = "Question 2::";
#2. define a function "doubles," that , given a list L, will return
#   a list with every element in L repeated, e.g:
#   doubles(1,2,3) should return (1,1,2,2,3,3).
#   In Scheme, I would write this as
#   (define (doubles m) (if (null? m) m
#                                   (cons (car m) (cons (car m) (doubles (cdr m))))))
#   However, in Perl you don't have to do this recursively.
#   You can use "push". The empty list is just ().  Try the foreach loop.
#   The function should be non-destructive: it should construct a new list.

# Doubles
# Define local array to keep the global array unchanged
# Define array for new list
# For each element in initial array, push that element twice onto the
# new list
# Return the new list

sub doubles {
    my @A = @_;
    my @newA = ();
    foreach my $x (@A) {
        push(@newA, $x);
        push(@newA, $x);
    }
    @newA;
}

print $Z, "doubles(1,2,3) is ", doubles(1,2,3), "\n";


$Z = "Question 3::";
#3. Write the Perl version of the "howmany" higher-order function
#   for array/lists.    For example,
#       howmany( sub{$_[0] > 5}, (3,6,2,8,1) )
#   should return 2, because there are two numbers in the list that are
#   greater than 5.

# Howmany
# $f --> function to satisfy
# $n --> initial count of elements that satisfy condition (0)
# @A --> list of elements to check against $f
# If the list is empty, return $n (the number of elements that satisfy $f)
# Otherwise, take the first element of @A
#   If that element satisfies $f,
#       call 'howmany' on the rest of the list incrementing $n
#   Otherwise,
#       call 'howmany' on the rest of the list leaving $n alone

sub howmany{
    my($f,$n,@A) = @_;
    if (@A==()) {return $n;}
    else {
        my ($carA,@cdrA) = @A;
        if ($f->($carA) == 1){
            return howmany($f,$n+1,@cdrA); }
        else {
            return howmany($f,$n,@cdrA); }
    }
}

print $Z, "howmany( sub{\$_[0] > 5}, 0, (3,6,2,8,1) ) returns ", howmany( sub{$_[0] > 5}, 0, (3,6,2,8,1) );
print "\n";


$Z = "Question 4::";
#4. To prepare for a style of oop in perl,
#   write the following Scheme closure-function in Perl:
#
#   (define (makecounter)
#        (let ((x 0)) (lambda () (begin (set! x (+ x 1)) x))))
#
#   You need to understand the last section of the tutorial, and read
#   the "bank accounts in perl" example.    Note that you cannot use
#   a global variable for x since makecounter must be able to create
#   different "instances" of the counter function, each with its own
#   local x to count up from.   Spend some time to think about this!
#   Note the "lambda" that occurs inside the function definition.
#   Your Perl program must emulate this structure.
#
#   After you've written the function and tested it, take a moment
#   to be proud of yourself, then change the word "my" in your program
#   to "local." Observe and explain what happens.

### If "my" is changed to "local", all instances of 'makecounter'
### share the same 'local' counter.  Incrementing one counter,
### increments all counters.

# makecounter
# Define local (my) var x to hold counter
# Define "increment" function to increment x by 1
# Return 'interface' function to retreive counter or increment
# counter based on input string

sub makecounter {
    my $x = 0;
    my $increment = sub { $x += 1; };

    sub {
        my $method = $_[0];
        if ($method eq inquiry) { return $x }
        if ($method eq increment) { return $increment }
        else { die "error"; }
    }
}

# Simpler version
# If the program just needs to count, it can simply return the count that counts
# If the value needs to be retrieved, simply print the value when you call
# the function.

#sub makecounter {
#   my $x = 0;
#   sub { $x += 1; };
#}

print $Z, "Account A created..\n";
print $Z, "Account B created..\n";
$a = makecounter();
$b = makecounter();

print $Z, "Account A incremented..\n";
$a->(increment)->();
print $Z, "Account A incremented..\n";
$a->(increment)->();
print $Z, "Account A incremented..\n";
$a->(increment)->();
print $Z, "Account B incremented..\n";
$b->(increment)->();

print $Z, "Account A: ", $a->(inquiry), "\n";
print $Z, "Acoount B: ", $b->(inquiry), "\n";

#$a = makecounter();
#$b = makecounter();
#$a->();
#$a->();
#print "a: ", $a->(), "\n";
#print "a: ", $b->(), "\n";



# --------------- Part II. OOP with Closures in Perl    -------------------

print "\n---------------------------------------\n";
print "Modularity, Objects and State Exercises\n";
print "---------------------------------------\n\n";

#   The rest of the assignment can be completed with EITHER SCHEME OR PERL,
#   However, both versions are required for graduate students.
#   Do the exercises from the handout "Modularity, Objects, and State",
#   numbers 3.1-3.5.

$Z = "Question 3.1::";
# 3.1 make-accumulator function
#
# Similar idea to the 'makecounter' function above

sub make_accumulator {
    my $x = @_[0];
    sub { $x += @_[0]; };
}


print $Z, "Accum A created with 10\n";
print $Z, "Accum B created with 10\n";
$a = make_accumulator(10);
$b = make_accumulator(10);
print $Z, "Accum A incremneted with 20\n";
$a->(20);
print $Z, "Accum A incremneted with 30\n";
$a->(30);
print $Z, "Accum A incremneted with 40\n";
print $Z, "Accum B incremneted with 0\n";
print $Z, "Accum A: ", $a->(40), "\n";
print $Z, "Accum B: ", $b->(0), "\n";


$Z = "Question 3.2::";
# 3.2 make-monitored function
#
# Monitors the number of times a function was called

# square
# Returns the square of the input
sub square{
    my $sq = @_[0];
    $sq*$sq;
}

# make_monitored
# Initialized with a function to call
# Returns subroutine to handle counter and call function
sub make_monitored {
    my $f = @_[0];
    my $count = 0;

    sub {
        my $method = $_[0];
        if ($method eq how_many_calls) { return $count }
        if ($method eq reset_count) { return $count = 0 }
        else {
            $count += 1;
            $f->($method)
        }
    }
}


print $Z, "Monitored Square Function Created..\n";
$a2 = make_monitored(\&square);
print $Z, "5 squared.. ", $a2->(5), "\n";
print $Z, "6 squared.. ", $a2->(6), "\n";
print $Z, "7 squared.. ", $a2->(7), "\n";
print $Z, "How many times called? ", $a2->('how_many_calls'), "\n";


$Z = "Question 3.3::";
# 3.3 password-protected make-account function
#
# Code Template provided courtesy of Dr. Liang
# from .../csc123/perlbank.txt

# Added dummy function to execute nothing if incorrect password was passed


sub make_account {
    my $balance = $_[0];
    my $password = $_[1];

    my $inquiry = sub { $balance };
    my $deposit = sub { $balance = $balance + $_[0]; };

    my $chargefee = sub { $balance -= 3; }; # "private" method
    my $withdraw = sub
            { $balance = $balance - $_[0]; &$chargefee(); };

    my $dummy = sub {};

    # return interface function:
    sub {
        my $method = $_[0]; # requested method
        my $attempted_password = $_[1];
        if ($attempted_password eq $password){
            if ($method eq withdraw) { return $withdraw; }
            if ($method eq deposit) { return $deposit; }
            if ($method eq inquiry) { return &$inquiry(); }
             else { die "error"; }
        } else { print "Incorrect password! You fool!\n"; return $dummy;}
    }
}

print $Z, "Account A created wiht \$100.. password: secret\n";
$a3 = make_account(100, "secret");
print $Z, "Account A withdrew \$50.. password: secret\n";
$a3->(withdraw, "secret")->(50);
print $Z, "Account A deposited \$150.. password: ecret\n";
$a3->(deposit, "ecret")->(150);
print $Z, "Account A has \$", $a3->(inquiry, "secret"), "\n";

$Z = "Question 3.4::";
# 3.4 authority-alerting password-protected make-account function
#
#   Added local var $authority to count the number of incorrect password
#   attempts.  If more htan 7, the "call_the_cops" function is called
#   There was an attempt to lock the account if this condiiton was met
#   as well; however, I couldn't make perl's undefined function call
#   go away.

sub make_accountA {
    my $balance = $_[0];
    my $password = $_[1];

    my $inquiry = sub { $balance };
    my $deposit = sub { $balance = $balance + $_[0]; };

    my $chargefee = sub { $balance -= 3; }; # "private" method
    my $withdraw = sub
            { $balance = $balance - $_[0]; &$chargefee(); };

    my $dummy = sub {};

    # return interface function:
    sub {
        my $method = $_[0]; # requested method
        my $attempted_password = $_[1];
        if ($attempted_password eq $password){
            if ($method eq withdraw) { return $withdraw; }
            if ($method eq deposit) { return $deposit; }
            if ($method eq inquiry) { return &$inquiry(); }
             else { die "error"; }
        } else { print "Incorrect password! You fool!\n"; return $dummy;}
    }
}

print $Z, "Account A created wiht \$100.. password: secret\n";
$a3 = make_account(100, "secret");
print $Z, "Account A withdrew \$50.. password: secret\n";
$a3->(withdraw, "secret")->(50);
print $Z, "Account A deposited \$150.. password: ecret\n";
$a3->(deposit, "ecret")->(150);
print $Z, "Account A has \$", $a3->(inquiry, "secret"), "\n";

$Z = "Question 3.4::";
# 3.4 authority-alerting password-protected make-account function
#
#   Added local var $authority to count the number of incorrect password
#   attempts.  If more htan 7, the "call_the_cops" function is called
#   There was an attempt to lock the account if this condiiton was met
#   as well; however, I couldn't make perl's undefined function call
#   go away.

sub make_accountB {
    my $balance = $_[0];
    my $password = $_[1];

    my $inquiry = sub { $balance };
    my $deposit = sub { $balance = $balance + $_[0]; };

    my $chargefee = sub { $balance -= 3; }; # "private" method
    my $withdraw = sub
            { $balance = $balance - $_[0]; &$chargefee(); };

    my $authority = 0;
    #my $admin_password = "admin";
    #my $locked = "0";
    #my $unlock = sub { $locked = 0; $authority = 0; };
    my $increaseheat = sub { print @Z, "Incorrect password! You fool!\n";
        $authority += 1};

    my $call_the_cops = sub { #$locked = "1";
         print $Z, "The authorities have been alerted!\n" };

    sub {
        #if (not $locked){
        #   print "Hello\n";
        #   print $locked, $authority;
            my $dummy = sub {};
            my $method = $_[0]; # requested method
            my $attempted_password = $_[1];
            if ($attempted_password eq $password){
                if ($method eq withdraw) { return $withdraw; }
                if ($method eq deposit) { return $deposit; }
                if ($method eq inquiry) { return &$inquiry(); }
                 else { print "error\n"; }
            } else {
                &$increaseheat();
                if ($authority > 7) { return &$call_the_cops(); }
                return $dummy;
            }
        #} else {
        #   print "Go Away\n";
        #   print $locked, $authority;
        #   my $method = $_[0];
        #   my $attempted_password = $_[1];
        #   if ($attempted_password eq $admin_password){
        #       if ($method eq unlock) {  return &$unlock(); }
        #       else { print "waiting for authroities\n"; }
        #   };
        #}
    }
}

print $Z, "Account A created with \$100, password: secret\n";
$a4 = make_accountB(100, secret);
print $Z, "Account A withdrew \$50, password: ecret\n";
$a4->(withdraw, ecret)->(50);
print $Z, "Account A withdrew \$50, password: ecret\n";
$a4->(withdraw, ecret)->(50);
print $Z, "Account A withdrew \$50, password: ecret\n";
$a4->(withdraw, ecret)->(50);
print $Z, "Account A withdrew \$50, password: ecret\n";
$a4->(withdraw, ecret)->(50);
print $Z, "Account A withdrew \$50, password: ecret\n";
$a4->(withdraw, ecret)->(50);
print $Z, "Account A withdrew \$50, password: ecret\n";
$a4->(withdraw, ecret)->(50);
print $Z, "Account A withdrew \$50, password: ecret\n";
$a4->(withdraw, ecret)->(50);
#print $Z, "Account A withdrew \$500, password: ecret\n";
#$a4->(withdraw, ecret)->(50);
#$a4->(unlock, admin);
print $Z, "Account A withdrew \$50, password: secret\n";
$a4->(withdraw, "secret")->(50);
print $Z, "Account A deposited \$50, password: secret\n";
$a4->(deposit, "secret")->(50);

print $Z, "Acoount A has \$", $a4->(inquiry, "secret"), "\n";


$Z = "Question 3.5::";
# 3.5 password-protected make-joint function
#
#   Added local var $authority to count the number of incorrect password
#   attempts.  If more htan 7, the "call_the_cops" function is called
#   There was an attempt to lock the account if this condiiton was met
#   as well; however, I couldn't make perl's undefined function call
#   go away.


sub make_joint {
    my ($account, $password, $joint_password) = @_;

    my $dummy = sub {};

    # return interface function:
    sub {
        my $method = $_[0]; # requested method
        my $attempted_password = $_[1];
        if (($attempted_password eq $password) or ($attempted_password eq $joint_password)){
            $account->($method, $password);
        } else { print "Incorrect password! You fool!\n"; return $dummy;}
    }
}

print $Z, "Account A created with \$100, password: secret\n";
$a5 = make_account(100, "secret");
print $Z, "Account A withdrew \$50, password: secret\n";
$a5->(withdraw, "secret")->(50);
print $Z, "Account B deposited \$150, password: secret\n";
$a5->(deposit, "secret")->(150);
print $Z, "Account A has \$", $a5->(inquiry, "secret"), "\n";
print $Z, "Account B joint A, password: notsecret\n";
$b5 = make_joint($a5, "secret", "notsecret");
print $Z, "Account B withdrew \$120, password: notsecret\n";
$b5->(withdraw, "notsecret")->(120);
print $Z, "Account A has \$", $b5->(inquiry, "notsecret"), "\n";
print $Z, "account B has \$", $a5->(inquiry, "secret"), "\n";


#   EXTRA CREDIT

#   To be a good programmer you need to have the ability to learn on
#   your own and do so constantly.  Research Perl's ability for matching
#   regular expressions, in particular the "split" "s///" and "=~" operations.
#   Using my "webclient.txt" program as a template, write a program that
#   downloads a homepage and extract all http links from that page, and print
#   them.   That is, extract all strings in the html source of the homepage
#   that are in the context <a href="http://...">
