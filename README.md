# Debugging

For debugging, you can use this son of a gun:

    docker build -t ausbin/docquipper .
    docker run -it --rm -v $(pwd):/quipper ausbin/docquipper bash
