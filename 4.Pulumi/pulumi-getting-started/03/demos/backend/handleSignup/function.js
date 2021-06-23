/**
 * Responds to any HTTP request.
 *
 * @param {!express:Request} req HTTP request context.
 * @param {!express:Response} res HTTP response context.
 */
module.exports.handleSignup = (req, res) => {
  res.set("Access-Control-Allow-Origin", "*");
  if(req.method === "OPTIONS") {
    res.set("Access-Control-Allow-Methods", "GET");
    res.set("Access-Control-Allow-Headers", "Content-Type");
    res.set("Access-Control-Max-Age", "60");
    return;
  }

  res.status(200)
    .append("Content-Type", "application/json")
    .send({
      message: "Request received, we'll be reaching out to you soon!"
    });
}
