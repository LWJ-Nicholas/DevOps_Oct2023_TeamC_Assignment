
        # Return a response (you can redirect or render a template)
        return render_template('success.html', name=name)  # Render a success page with the submitted name

    return render_template('CreateEntry.html')


if __name__ == '__main__':
    app.run(debug=True)