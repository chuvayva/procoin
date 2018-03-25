import $ from "jquery";
import _ from "lodash";
import signTransfer from "./sign-transfer";
import "./signed-transfer.css.sass";

document.addEventListener("DOMContentLoaded", () => {
  const userFieldsHeading = $(".js-user-fields-heading");
  const userFields = $(".js-transfer-field").not("div");
  const userFieldsNextButton = $(".js-user-fields-next");

  const signHeading = $(".js-sign-heading");
  const privateKeyInput = $(".js-private-key");
  const signButton = $(".js-sign-next");
  const sendButton = $(".js-send");

  const to = () => $("select#transfer_to option:selected");
  const amount = $("#transfer_amount");
  const fee = $("#transfer_fee");
  const nonce = $("#transfer_nonce");
  const tokenContract = $("#transfer_token_contract");
  const signature = $("#transfer_signature");

  userFields.change(() => {
    const userFieldsValid = _(userFields)
      .map("value")
      .every(Boolean);

    userFieldsNextButton.toggleClass("disabled", !userFieldsValid);
  });

  userFieldsNextButton.click(() => {
    userFieldsHeading.html(
      `Параметры перевода: <span class="bold">${to().text()}, ${amount.val()} + ${fee.val()}</span>`
    );
  });

  privateKeyInput.change(() => {
    const privateKey = privateKeyInput.val().trim();
    const privateKeyValid = /^[a-fA-F0-9]{64}$/.test(privateKey);

    signButton.toggleClass("disabled", !privateKeyValid);
  });

  signButton.click(() => {
    const signatureValue = signTransfer(
      tokenContract.val(),
      to().val(),
      amount.val(),
      fee.val(),
      nonce.val(),
      privateKeyInput.val().trim()
    );

    $(".js-sent-to").html(to().html());
    $(".js-sent-amount").html(amount.val());
    $(".js-sent-fee").html(fee.val());
    signature.val(signatureValue);

    signHeading.html(
      `Подпись: <span class="bold glyphicon glyphicon-ok"></span>`
    );

    sendButton.removeAttr("disabled");
  });
});
