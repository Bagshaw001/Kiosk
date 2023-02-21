<?php
/*##########Script Information#########
  # Purpose: Send mail Using PHPMailer#
  #          & Gmail SMTP Server 	  #
  # Created: 24-11-2019 			  #
  #	Author : Hafiz Haider			  #
  # Version: 1.0					  #
  # Website: www.BroExperts.com 	  #
  #####################################*/

//Include required PHPMailer files
require 'includes/PHPMailer.php';
require 'includes/SMTP.php';
require 'includes/Exception.php';
require '../utils/env_manager.php';

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;
//Create instance of PHPMailer
//Define name spaces
function send_mail($reciever_mail, $body, $image_path = null, $email_header)
{

  $mail = new PHPMailer();
  //Set mailer to use smtp
  $mail->isSMTP();
  //Define smtp host
  $mail->Host = "smtp.gmail.com";
  //Enable smtp authentication
  $mail->SMTPAuth = true;
  //Set smtp encryption type (ssl/tls)
  $mail->SMTPSecure = "tls";
  //Port to connect smtp
  $mail->Port = "587";
  //Set gmail username
  $mail->Username = "omieibibagshaw007@gmail.com";
  //Set gmail password
  $mail->Password = stmp_password();
  //Email subject
  $mail->Subject = "Test email using PHPMailer";
  //Set sender email
  $mail->setFrom('omieibibagshaw007@gmail.com');
  //Enable HTML
  $mail->isHTML(true);
  //Attachment
  $mail->addAttachment($image_path);
  //Email body
  $mail->Body = "<h1>" . $email_header . "</h1></br><p>" . $body . "</p>";
  //Add recipient
  $mail->addAddress($reciever_mail);
  //Finally send email
  if ($mail->send()) {
  } else {
    echo "Message could not be sent. Mailer Error: " +
      $mail->ErrorInfo;
    return false;
  }
  //Closing smtp connection
  return $mail->smtpClose();
}
