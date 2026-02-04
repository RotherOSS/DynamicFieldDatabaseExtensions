# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2026 Rother OSS GmbH, https://otobo.io/
# --
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
# --

use v5.24;
use strict;
use warnings;
use namespace::autoclean;
use utf8;

# core modules

# CPAN modules
use Test2::V0;

# OTOBO modueles
use Kernel::System::UnitTest::RegisterDriver;    # Set up the test driver $Self and $Kernel::OM
use Kernel::System::DynamicField;
use Kernel::System::DynamicField::Backend;
use Kernel::System::VariableCheck qw(IsArrayRefWithData);

# get helper object
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

my $RandomID = $Helper->GetRandomNumber();
my $UserID   = 1;

my $ConfigObject       = $Kernel::OM->Get('Kernel::Config');
my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
my $BackendObject      = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
my $LayoutObject       = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

# Define DB test parameters.
my $DBType     = '';
my $DBName     = $ConfigObject->Get('Database');
my $DBUser     = $ConfigObject->Get('DatabaseUser');
my $DBPassword = $ConfigObject->Get('DatabasePw');
my $DBServer   = $ConfigObject->Get('DatabaseHost');

# Check if DB is MySQL, finish test if it is not.
if ( $ConfigObject->Get('DatabaseDSN') =~ /^DBI:mysql/ ) {
    $DBType = 'mysql';
}
elsif ( $ConfigObject->Get('DatabaseDSN') =~ /^DBI:Pg/ ) {
    $DBType = 'postgresql';
}
elsif ( $ConfigObject->Get('DatabaseDSN') =~ /^DBI:Oracle/ ) {
    $DBType = 'oracle';
}
else {
    skip_all("Finishing prematurely test, unknown database type");
}

my %Queue = $Kernel::OM->Get('Kernel::System::Queue')->QueueGet(
    ID => 1,
);

# Create ticket as object
my $TicketID = $Kernel::OM->Get('Kernel::System::Ticket')->TicketCreate(
    Title    => 'Some Ticket Title',
    Queue    => 'Raw',                 # or QueueID => 123,
    Lock     => 'unlock',
    Priority => '3 normal',
    State    => 'new',
    OwnerID  => $UserID,
    UserID   => $UserID,
);
ok( $TicketID, 'Ticket successfully created' );

my @TestConfigs = (
    {
        DynamicFieldConfig => {
            Config => {
                CacheTTL       => 86400,
                CaseSensitive  => undef,
                DBName         => $DBName,
                DBTable        => "queue",
                DBType         => $DBType,
                Driver         => "",
                Identifier     => 1,
                Link           => "",
                LinkPreview    => "",
                Multiselect    => undef,
                Password       => $DBPassword,
                Port           => "",
                PossibleValues => {
                    Displayfield_1  => "",
                    Displayfield_2  => "",
                    Displayfield_3  => "",
                    Displayfield_4  => "",
                    FieldDatatype_1 => "INTEGER",
                    FieldDatatype_2 => "TEXT",
                    FieldDatatype_3 => "INTEGER",
                    FieldDatatype_4 => "DATE",
                    FieldFilter_1   => "",
                    FieldFilter_2   => "",
                    FieldFilter_3   => "",
                    FieldFilter_4   => "",
                    FieldLabel_1    => "id",
                    FieldLabel_2    => "name",
                    FieldLabel_3    => "valid",
                    FieldLabel_4    => "create",
                    FieldName_1     => "id",
                    FieldName_2     => "name",
                    FieldName_3     => "valid_id",
                    FieldName_4     => "create_time",
                    Listfield_1     => "on",
                    Listfield_2     => "on",
                    Listfield_3     => "on",
                    Listfield_4     => "on",
                    Searchfield_1   => "on",
                    Searchfield_2   => "on",
                    Searchfield_3   => "",
                    Searchfield_4   => "",
                    ValueCounter    => 4,
                },
                ResultLimit  => "",
                Searchprefix => "",
                Searchsuffix => "",
                Server       => $DBServer,
                SID          => "",
                Tooltip      => "",
                User         => $DBUser,
            },
            FieldOrder    => 1,
            FieldType     => "Database",
            InternalField => 0,
            Label         => "TicketDB00$RandomID",
            Name          => "TicketDB00$RandomID",
            ObjectType    => "Ticket",
            Reorder       => 0,
            ValidID       => 1,
        },
        Value        => "1",
        DisplayValue => {
            Class       => "DynamicFieldType_Database",
            Link        => "",
            LinkPreview => "",
            Title       => "1",
            Value       => "1",
        },
    },
    {
        DynamicFieldConfig => {
            Config => {
                CacheTTL       => 86400,
                CaseSensitive  => undef,
                DBName         => $DBName,
                DBTable        => "queue",
                DBType         => $DBType,
                Driver         => "",
                Identifier     => 1,
                Link           => "",
                LinkPreview    => "",
                Multiselect    => undef,
                Password       => $DBPassword,
                Port           => "",
                PossibleValues => {
                    Displayfield_1  => "General",
                    Displayfield_2  => "General",
                    Displayfield_3  => "Header00",
                    Displayfield_4  => "Header01",
                    FieldDatatype_1 => "INTEGER",
                    FieldDatatype_2 => "TEXT",
                    FieldDatatype_3 => "INTEGER",
                    FieldDatatype_4 => "DATE",
                    FieldFilter_1   => "",
                    FieldFilter_2   => "",
                    FieldFilter_3   => "",
                    FieldFilter_4   => "",
                    FieldLabel_1    => "id",
                    FieldLabel_2    => "name",
                    FieldLabel_3    => "valid",
                    FieldLabel_4    => "create",
                    FieldName_1     => "id",
                    FieldName_2     => "name",
                    FieldName_3     => "valid_id",
                    FieldName_4     => "create_time",
                    Listfield_1     => "on",
                    Listfield_2     => "on",
                    Listfield_3     => "on",
                    Listfield_4     => "on",
                    Searchfield_1   => "on",
                    Searchfield_2   => "on",
                    Searchfield_3   => "",
                    Searchfield_4   => "",
                    ValueCounter    => 4,
                },
                ResultLimit  => "",
                Searchprefix => "",
                Searchsuffix => "",
                Server       => $DBServer,
                SID          => "",
                Tooltip      => "",
                User         => $DBUser,
            },
            FieldOrder    => 1,
            FieldType     => "Database",
            InternalField => 0,
            Label         => "TicketDB01$RandomID",
            Name          => "TicketDB01$RandomID",
            ObjectType    => "Ticket",
            Reorder       => 0,
            ValidID       => 1,
        },
        Value        => "1",
        DisplayValue => {
            Class       => "DynamicFieldType_Database",
            Link        => "",
            LinkPreview => "",
            Title       => "1",
            Value       =>
                "<span>1</span><br/><span>Postmaster</span><br/><br/><b>Header00</b><br/><span>$Queue{ValidID}</span><br/><br/><b>Header01</b><br/><span>$Queue{CreateTime}</span>",
        },
        SetHeaders => [
            "Header00",
            "Header01"
        ],
    },
);

for my $TestConfig (@TestConfigs) {
    state $TestCount = 0;
    $TestCount++;

    subtest "DynamicFieldDBExtension test $TestCount" => sub {

        # Create dynamic field DB
        my $FieldID = $DynamicFieldObject->DynamicFieldAdd(
            $TestConfig->{DynamicFieldConfig}->%*,
            UserID => $UserID,
        );
        ok( $FieldID, 'DynamicField created successfully' );

        my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
            ID => $FieldID,
        );

        if ( $TestConfig->{SetHeaders} ) {
            $Helper->ConfigSettingChange(
                Valid => 1,
                Key   => 'DynamicFieldDB::DisplayfieldHeaders',
                Value => $TestConfig->{SetHeaders},
            );
        }

        # Set value
        my $Success = $BackendObject->ValueSet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ObjectID           => $TicketID,
            Value              => $TestConfig->{Value},
            UserID             => $UserID,
        );
        ok( $Success, 'ValueSet successful' );

        my $DisplayValue = $BackendObject->DisplayValueRender(
            DynamicFieldConfig => $DynamicFieldConfig,
            Value              => $TestConfig->{Value},
            HTMLOutput         => 1,
            LayoutObject       => $LayoutObject,
        );

        is(
            $DisplayValue,
            hash {
                for my $CheckKey ( keys $TestConfig->{DisplayValue}->%* ) {
                    field $CheckKey => $TestConfig->{DisplayValue}{$CheckKey};
                }

                end();
            },
            'DisplayValue ok'
        );
    };
}

done_testing;
