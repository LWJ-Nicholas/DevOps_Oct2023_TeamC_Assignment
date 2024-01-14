from flask import Flask, render_template, request

app = Flask(__name__)


# Route for the form page
@app.route('/form', methods=['GET', 'POST'])
def form():
    if request.method == 'POST':
        # Access form data
        name = request.form['name']
        email = request.form['email']
        message = request.form['message']

        # Do something with the form data (you can process or store it)
        # For example, print the data to the console
        print(f"Name: {name}, Email: {email}, Message: {message}")

        # Return a response (you can redirect or render a template)
        return render_template('success.html', name=name)  # Render a success page with the submitted name

    return render_template('CreateEntry.html')


if __name__ == '__main__':
    app.run(debug=True)