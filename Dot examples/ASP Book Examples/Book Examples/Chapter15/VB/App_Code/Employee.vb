''' <summary>
''' Represents an employee of Acme.com
''' </summary>
Public Class Employee

    Private _firstName As String
    Private _lastName As String

    ''' <summary>
    ''' The employee first name
    ''' </summary>
    Public ReadOnly Property FirstName() As String
        Get
            Return _firstName
        End Get
    End Property

    ''' <summary>
    ''' The employee last name
    ''' </summary>
    Public ReadOnly Property LastName() As String
        Get
            Return _lastName
        End Get
    End Property


    ''' <summary>
    ''' Returns an employee from the database
    ''' </summary>
    ''' <param name="id">The unique employee identifier</param>
    ''' <returns>An instance of the Employee class</returns>
    Public Shared Function getEmployee(ByVal id As Integer) As Employee
        Return Nothing
    End Function

    ''' <summary>
    ''' Initializes an employee
    ''' </summary>
    ''' <param name="firstName">First Name</param>
    ''' <param name="lastName">Last Name</param>
    Public Sub New(ByVal firstName As String, ByVal lastName As String)
        _firstName = firstName
        _lastName = lastName
    End Sub

End Class

