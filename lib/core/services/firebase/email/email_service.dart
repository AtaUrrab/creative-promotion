// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EmailService {
  final String _name;
  final String _email;
  final String _role;

  final _format = DateFormat("dd/MM/yyyy-h:m a");
  final _mailRef = FirebaseFirestore.instance.collection("mail");
  final _companyEmail = "thecreativepromotioncompany@gmail.com";

  EmailService({
    required String name,
    required String email,
    required String role,
  })  : _role = role,
        _email = email,
        _name = name;

  newUser(Timestamp createdAt) {
    _toUserWaiting();
    _toAdminNewUser(createdAt);
  }

  acceptReq() {
    _toUserAcceptReq();
    _toAdminAcceptReq();
  }

  rejectReq() {
    _toUserRejectReq();
    _toAdminRejectReq();
  }

  block() {
    _toUserBlock();
    _toAdminBlock();
  }

  Future<void> _toUserWaiting() async {
    await _mailRef.add({
      "to": _email,
      "message": {
        "subject":
            "Welcome to Creative Promotion - Your Inventory Management Solution",
        "text": '''Dear $_name,

Thank you for choosing Creative Promotion, your ultimate inventory management solution. We are excited to have you on board and assist you in streamlining your stock management processes.
        
Upon registering for our app, we understand that you are eager to dive right into managing your inventory effectively. Our team is currently reviewing the information you provided during the registration process. This brief verification process ensures the accuracy and security of your data.
        
Please note that this review typically takes up to 24 hours. We kindly request your patience as we work diligently to complete the necessary checks. Rest assured that once the review is complete, you will receive an email confirming your successful registration and further instructions on getting started with Creative Promotion.
        
If you have any questions or require assistance during the registration review period or beyond, please do not hesitate to contact our dedicated support team. We are here to provide you with prompt and reliable assistance.
        
Thank you again for choosing Creative Promotion. We look forward to welcoming you officially to our app and helping you achieve remarkable inventory management success.

Best regards,
        
Creative Promotion Mobile App
Customer Support Representative
        ''',
      }
    });
  }

  Future<void> _toAdminNewUser(Timestamp createdAt) async {
    await _mailRef.add({
      "to": _companyEmail,
      "message": {
        "subject":
            "New User Registration - Approval Required for ${_role.toUpperCase()}",
        "text": '''
Dear Admin,

I hope this email finds you well. We have a new user registration request for Creative Promotion, our cutting-edge inventory management mobile application.
      User Details:
      
Name: $_name
Email: $_email
Registration Date: ${_format.format(createdAt.toDate())}
      
As the designated authority for approving user registrations, please review and decide on this user's request to join our app.

Thank you for your attention to this matter. Your timely response will help us ensure a seamless user experience and maintain the integrity of our user base.

Best regards,
App Administrator Creative Promotion Mobile App
       ''',
      }
    });
  }

  Future<void> _toUserAcceptReq() async {
    await _mailRef.add({
      "to": _email,
      "message": {
        "subject": "Registration Approved - Welcome to Creative Promotion!",
        "text": '''
        Dear $_name,
        We are thrilled to inform you that your registration request for Creative Promotion, our state-of-the-art inventory management mobile application, has been approved! Welcome to our growing community of empowered inventory managers.
        Your commitment to effective stock management has impressed our team, and we believe that Creative Promotion will be an invaluable tool for you in streamlining your inventory processes. Get ready to experience the ease and efficiency of our app as you take control of your stock management activities.
        We genuinely appreciate your patience during the review process and apologize for any inconvenience caused. It was essential to ensure the security and integrity of our user base. Now that you are officially a part of Creative Promotion, we encourage you to explore the app's features and maximize its capabilities.
        If you have any questions or require assistance, please do not hesitate to contact our dedicated support team. We are here to provide you with timely and reliable assistance.
        Once again, congratulations on becoming a Creative Promotion user! We are confident that our app will revolutionize your inventory management practices and help you achieve remarkable results.
        Thank you for choosing Creative Promotion. We look forward to supporting you on your journey toward efficient stock management.
        
        Best regards,
        Creative Promotion Mobile App
        Customer Support Representative
        ''',
      }
    });
  }

  Future<void> _toAdminAcceptReq() async {
    await _mailRef.add({
      "to": _companyEmail,
      "message": {
        "subject":
            "Approval Confirmation - Agent Registration for Creative Promotion",
        "text": '''
Dear Admin,

I hope this email finds you well. You have reviewed and approved the registration request from $_role $_name for Creative Promotion App.

The reviewing process was carefully assessed by the provided information and ensured its accuracy and validity. The $_role $_name meets the criteria to become a valued user of Creative Promotion.
        
As a Creative Promotion user, $_role $_name will have access to various features that will greatly simplify their stock management processes. 

Thank you for your attention to this registration process and ongoing support in making Creative Promotion a leading inventory management solution.
        
Best regards,

Creative Promotion Mobile App
Customer Support Representative
        ''',
      }
    });
  }

  Future<void> _toUserRejectReq() async {
    await _mailRef.add(
      {
        "to": _email,
        "message": {
          "subject": "Registration Update - Rejected",
          "text": '''
        Dear $_name,
        
        We regret to inform you that your registration request for Creative Promotion, our inventory management mobile application, has been declined. We understand this may be disappointing news, and we apologize for any inconvenience caused.
        
        The administrator carefully considered the decision to reject your registration request, taking into account various factors related to our app's purpose, user base, and the specific requirements of Mobo Oil's inventory management processes.
  
        If you believe there may have been a misunderstanding or have any further questions regarding the rejection of your registration, we encourage you to contact our support team. We will do our best to provide clarification and address any concerns you may have.
        
        We value your interest in Creative Promotion and sincerely apologize for any inconvenience caused by this outcome. We wish you the best of luck finding an inventory management solution that effectively meets your needs.
        
        Thank you for considering Creative Promotion, and we appreciate your understanding.
        
        Best regards,

        Creative Promotion Mobile App
        Customer Support Representative
        ''',
        }
      },
    );
  }

  Future<void> _toAdminRejectReq() async {
    await _mailRef.add(
      {
        "to": _companyEmail,
        "message": {
          "subject": "User Registration Rejection Notification",
          "text": '''
          Dear Admin,
          
          I hope this email finds you well. The registration request from User $_name for Creative Promotion, our inventory management mobile application, has been carefully reviewed and, unfortunately, rejected.
          
          If User $_name contacts you or expresses any concerns regarding the rejection of their registration, please direct them to our customer support team. Our team is prepared to assist them, address their queries, and suggest alternative solutions that suit their needs better.
          
          Thank you for your attention to this matter and your ongoing support in maintaining the integrity and effectiveness of Creative Promotion. Please do not hesitate to contact me if you have any questions or require further information.

          Best regards,
          Creative Promotion Mobile App
          App Administrator
          ''',
        }
      },
    );
  }

  Future<void> _toUserBlock() async {
    await _mailRef.add(
      {
        "to": _email,
        "message": {
          "subject": "Account Restriction Notification",
          "text": '''
Dear $_name,

We regret to inform you that your access to Creative Promotion, our inventory management mobile application, has been restricted/blocked. This decision has been made based on a review of your account and associated activities.
Upon thorough evaluation, it has come to our attention that there have been violations of our terms of service or other guidelines governing the use of the app. As a result, we have found it necessary to restrict/block your account indefinitely.
We understand this news may be disappointing, and we apologize for any inconvenience caused. Our team is committed to upholding the integrity and security of our user community and ensuring that all users adhere to the prescribed guidelines and policies.
If you believe there may have been a misunderstanding or have any questions or concerns regarding this account restriction, please contact our support team. We will do our best to provide clarification and address any issues you may have.
Please note that attempting to create additional accounts or circumvent this account restriction is strictly prohibited. Any such actions may result in further consequences and impact your ability to use other services offered by our platform.
We appreciate your understanding and cooperation in this matter. Should there be any updates or changes to your account status, we will inform you accordingly.
Thank you for your previous interest in Creative Promotion, and we wish you the best in your future endeavors.

Best regards,

Creative Promotion Mobile App
Customer Support Representative 
          ''',
        }
      },
    );
  }

  Future<void> _toAdminBlock() async {
    await _mailRef.add(
      {
        "to": _companyEmail,
        "message": {
          "subject": "Account Restriction - User $_name",
          "text": '''
Dear Admin,

I hope this email finds you well. I am informing you that you have taken the necessary action to restrict/block the User $_name account in Creative Promotion, your inventory management mobile application.
After carefully reviewing User $_name's account and associated activities, you have determined that there have been violations of your terms of service or other guidelines governing the use of the app. In order to maintain the integrity and security of your user community, it was deemed necessary to restrict/block their account indefinitely.

Please note that you have communicated this action to the user via email, explaining the reasons for the account restriction/block. You have also provided them with information on contacting your support team should they have any questions or concerns.
We understand that each decision regarding account restrictions/blocks is important, and we appreciate your support and guidance throughout this process, as it contributes to maintaining the quality and trustworthiness of your app and user base.

Please do not hesitate to contact me if you require further information or have any additional questions regarding this account restriction/block. I am here to provide you with any necessary details or assistance.
Thank you for your attention to this matter and for your commitment to upholding the standards and guidelines of Creative Promotion.

Best regards,

Creative Promotion Mobile App
App Administrator
          ''',
        }
      },
    );
  }
}
