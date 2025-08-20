const nodemailer = require('nodemailer');
const mail = {
    user: process.env.MAIL_USER,
    pass: process.env.MAIL_PASS
}

// Create a test account or replace with real credentials.
const transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 587,
  tls: {
    rejectUnauthorized: false // Allow self-signed certificates
  },
  secure: false, // true for 465, false for other ports
  auth: {
    user: mail.user, // generated ethereal user
    pass: mail.pass, // generated ethereal password
  },
});

const sendEmail = async (email, subject, html) => {
  try {
    const info = await transporter.sendMail({
        from: `"Esportify" <Validation.esportify.com>`, // sender address
        to: email, 
        subject: subject,
        text: "Saludos, por favor validar el correo por medio del siguiente boton", // plain‑text body
        html: html // HTML body
    });
    console.log("Message sent: %s", info.messageId);
  } catch (error) {
    console.error("Error sending email:", error);
  }
};

const getTemplate = (name, token) => {
  return `
    <!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="./style.css" />
    <title>Confirmación de Cuenta</title>
  </head>
  <body>
    <div id="email__content">
      <h2>Hola, ${name}</h2>
      <p>Para confirmar tu cuenta, ingresa al siguiente enlace:</p>
      <a href="http://localhost:5000/api/users/confirmEmail/${token}">Confirmar Cuenta</a>
    </div>
  </body>
</html>`;
}


module.exports = { sendEmail, getTemplate };