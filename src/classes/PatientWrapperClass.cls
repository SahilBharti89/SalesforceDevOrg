public with sharing class PatientWrapperClass {
    
    
    public class contactWrapperPost{
        
        public String PatientId {get;set;} 
        public String ConDate {get;set;} 
        public String Type_Z {get;set;} 
        public String Action {get;set;} 
        
        public contactWrapperPost(){
            this.PatientId='';
            this.ConDate = '';
            this.Type_Z = '';
            this.Action = '';
        }
    }
    
    public class DoctorTreatingOsteoporosis {
        public String FullName;
        public String PhoneNumber;
        public String ZipCode;
    }
    
    
    public class Address {
        public String ZipCode;
        public String City;
        public String Country;
        public String Region;
        public String StreetAddress;
    }
    
    
    public class patientProfile {
        public String PatientId;
        public String EuropeanRegistrationCode;
        public String Title;
        public String FirstName;
        public String LastName;
        public String Gender;
        public String DateOfBirth;
        public String MobilePhoneNumber;
        public String EmailAddress;
        public Address Address;
        public DoctorTreatingOsteoporosis DoctorTreatingOsteoporosis;
        public DoctorTreatingOsteoporosis GeneralPractitioner;
        public String NurseCode;
        
        public patientProfile(){
            this.PatientId = '';
            this.EuropeanRegistrationCode = '';
            this.Title = '';
            this.FirstName = '';
            this.LastName = '';
            this.Gender = '';
            this.DateOfBirth = '';
            this.MobilePhoneNumber = '';
            this.EmailAddress = '';
            this.Address = new Address();
            this.DoctorTreatingOsteoporosis = new DoctorTreatingOsteoporosis();
            this.GeneralPractitioner = new DoctorTreatingOsteoporosis();
            this.NurseCode = '';
        }
        
    }
    
}